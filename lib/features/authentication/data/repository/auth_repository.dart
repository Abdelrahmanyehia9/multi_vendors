import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/service/database_service.dart';
import 'package:multi_vendor/core/utils/remote_database_constants.dart';
import 'package:multi_vendor/features/authentication/data/model/auth_user_model.dart';

import '../../../../core/service/auth_service.dart';

class AuthRepository {
  final AuthenticationService _authService;
  final DatabaseService _databaseService;

  const AuthRepository(this._authService, this._databaseService);

  Future<Either<AppException, Unit>> login(
    String email,
    String password,
  ) async {
    try {
      await _authService.signIn(email: email, password: password);
      return right(unit);
    } catch (e) {
      return left(e.toAppException);
    }
  }

  Future<Either<AppException, Unit>> signUp(
    String email,
    String password,
    AuthUserModel user
  ) async {
    try {
      await _authService.signUp(email: email, password: password);
      await fillData(user);
      return right(unit);
    } catch (e) {
      return left(e.toAppException);
    }
  }

  Future<void> fillData(AuthUserModel user) async {
    await _databaseService.CREATE(
      table: RemoteDatabaseConstants.profile_table,
      data: user.toJson(),
    );
  }
}
