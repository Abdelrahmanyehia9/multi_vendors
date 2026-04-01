import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/service/auth_service.dart';

class ResetPasswordRepository {
  final AuthenticationService _authService;
 const ResetPasswordRepository(this._authService);


  Future<Either<AppException, Unit>> sendForgetEmail(String email) async {
    try {
      await _authService.sendForgetPasswordEmail(email: email);
      return right(unit);
    } catch (e) {
      return left(e.toAppException);
    }
  }

  Future<Either<AppException, Unit>> changePassword(String password) async {
    try {
      await _authService.updateUser(password: password);
      return right(unit);
    } catch (e) {
      return left(e.toAppException);
    }
  }
}