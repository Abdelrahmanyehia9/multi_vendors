import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/models/base_user_model.dart';
import 'package:multi_vendor/features/authentication/data/repository/social_media_login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/service/auth_service.dart';

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
    BaseUserModel user,
  ) async {
    try{
       await _authService.signUp(
        email: email,
        password: password,
        data: user.toJson(),
      );
      return right(unit);
    }catch(e) {
      return left(e.toAppException);
    }
  }
  Future<Either<AppException, Unit>> sendOtp({
    required OtpChannel channel,
    required String phone,
  }) async {
    try {
      await _authService.sendOtp(phone: phone ,channel: channel);
      return right(unit);
    } catch (e) {
      return left(e.toAppException);
    }
  }
  Future<Either<AppException, Unit>> confirmOtp({
    required String otp,
    required String phone,
  }) async {
    try {
      await _authService.verifyOtp(phone: phone, otp: otp);
      return right(unit);
    } catch (e) {
      return left(e.toAppException);
    }
  }
  Future<Either<AppException, Unit>> socialLogin(
    SocialMediaAuthProvider provider,
  ) async {
    try {
      await provider.login();
      return right(unit);
    } catch (e) {
      return left(e.toAppException);
    }
  }
}
