import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/service/auth_service.dart';
import 'package:multi_vendor/shared/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final AuthenticationService _authService;
  const AuthRepository(this._authService);

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
    UserModel user,
  ) async {
    try {
      await _authService.signUp(
        email: email,
        password: password,
        data: user.toJson(),
      );
      return right(unit);
    } catch (e) {
      return left(e.toAppException);
    }
  }



  Future<Either<AppException, Unit>> socialLogin(
    OAuthProvider provider,
  ) async {
    try {
      await _authService.signInWithOAuth(provider)  ;
      return right(unit);
    } catch (e) {
      return left(e.toAppException);
    }
  }

}
