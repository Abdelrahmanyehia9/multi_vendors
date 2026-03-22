import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/utils/remote_database_constants.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/service/auth_service.dart';
import 'package:multi_vendor/core/service/database_service.dart';
import '../database/local_storage.dart';
import '../database/local_storage_constants.dart';
import '../errors/exceptions.dart';
import '../models/base_user_model.dart';

final class UserSessionHelper {
  final AuthenticationService _authService;
  final DatabaseService _databaseService;
  final LocalStorage _localStorage;

  const UserSessionHelper(this._authService, this._databaseService, this._localStorage);
  void setupListener({
    required void Function() onSignIn,
    required void Function() onSignOut,
    required void Function() onFirstTimeJoin,
    required void Function(BaseUserModel) onUpdateUser,
  }) {
    final bool firstTime = _localStorage.read(
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
      onSignIn.call();
    } else if (!firstTime) {
      onSignOut.call();
    }
  }

  Future<void>logout()async{
    await _authService.logout();
  }
  void finishIntro() {
    _localStorage.write(LocalStorageConstants.firstTime, false);
  }
  BaseUserModel? get cachedUser => _getLocalUser();
  Future<Either<AppException, BaseUserModel>> _getUserRemote(String id) async {
    try {
      final response = await _databaseService.GET_SINGLE(
        table: RemoteDatabaseConstants.profile_table,
        filter: (q) => q.eq(RemoteDatabaseConstants.id_column, id),
      );
      final BaseUserModel user = BaseUserModel.fromJson(response) ;
      _cacheUser(user) ;
      return right(user);

    } catch (e) {
      return left(e.toAppException);
    }
  }
  Future<void> _cacheUser(BaseUserModel user) async =>
      _localStorage.write(LocalStorageConstants.user, user.toJson());
  BaseUserModel? _getLocalUser() {
    final userJson = _localStorage.read(LocalStorageConstants.user);
    return userJson != null ? BaseUserModel.fromJson(userJson) : null;
  }
  Future<void> _clearLocalUser() async => await _localStorage.delete(LocalStorageConstants.user);
}