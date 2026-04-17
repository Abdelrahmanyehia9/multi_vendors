import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/models/user_model.dart';
import 'package:multi_vendor/core/utils/remote_database_constants.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/service/auth_service.dart';
import 'package:multi_vendor/core/service/database_service.dart';
import '../../database/local_storage.dart';
import '../../database/local_storage_constants.dart';
import '../../errors/exceptions.dart';

final class UserSessionHelper {
  final AuthenticationService _authService;
  final DatabaseService _databaseService;
  final LocalStorage _settingsStorage;
  final LocalStorage _cacheStorage;

  const UserSessionHelper(
      this._authService,
      this._databaseService,
      this._settingsStorage,
      this._cacheStorage,
      );

  void setupListener({
    required void Function() onSignIn,
    required void Function() onSignOut,
    required void Function() onFirstTimeJoin,
    required void Function(UserModel) onUpdateUser,
  }) {
    final bool firstTime = _settingsStorage.read(
      LocalStorageConstants.firstTime,
      defaultValue: true,
    );

    if (firstTime) onFirstTimeJoin.call();

    _authService.setupAuthListener(
          (id) async {
        final result = await _getUserRemote(id);
        result.fold((l) => null, (r) => onSignIn.call());
      },
          () {
        _clearLocalUser();
        onSignOut.call();
      },
          (id) async {
        final result = await _getUserRemote(id);
        result.fold((l) => null, onUpdateUser.call);
      },
    );

    if (_authService.isAuthenticated) {
      _getUserRemote(_authService.currentUser!.id).then(
            (result) => result.fold((l) => null, (r) => onSignIn.call()),
      );
    } else if (!firstTime) {
      onSignOut.call();
    }
  }

  Future<void> logout() async {
    await _authService.logout();
  }

  Future<void> finishIntro() async {
    await _settingsStorage.write(LocalStorageConstants.firstTime, false);
  }

  UserModel? get cachedUser => _getLocalUser();

  Future<Either<AppException, UserModel>> _getUserRemote(String id) async {
    try {
      final response = await _databaseService.GET_SINGLE(
        table: RemoteDatabaseConstants.profile_table,
        filter: (q) => q.eq(RemoteDatabaseConstants.id_column, id),
      );
      final UserModel user = UserModel.fromJson(response);
      await _cacheUser(user);
      return right(user);
    } catch (e) {
      return left(e.toAppException);
    }
  }

  Future<void> _cacheUser(UserModel user) async =>
      _cacheStorage.write(LocalStorageConstants.user, user.toJson());

  UserModel? _getLocalUser() {
    final userJson = _cacheStorage.read(LocalStorageConstants.user);
    return userJson != null ? UserModel.fromJson(userJson) : null;
  }

  Future<void> _clearLocalUser() async =>
      _cacheStorage.delete(LocalStorageConstants.user);
}