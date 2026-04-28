import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/service/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/shared/data/models/user_model.dart';

class OtpRepository {
 final AuthenticationService _authService;
  OtpRepository(this._authService);


 Future<Either<AppException, Unit>> sendOtp({
   required OtpChannel channel,
   required String phone,
   UserModel? user,
 }) async {
   try {
     await _authService.sendOtp(
       phone: phone,
       channel: channel,
       data: user?.toJson(),
     );
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
     await _authService.verifyOtp(phone: phone, otp: otp,);
     return right(unit);
   } catch (e) {
     return left(e.toAppException);
   }
 }


}