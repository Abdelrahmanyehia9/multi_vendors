import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/authentication/data/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginCubit extends Cubit<BaseState<Unit>>{
  final AuthRepository _authRepository;
  LoginCubit(this._authRepository) : super(const BaseState.initial());
  Future<void> login({required String email, required String password})async{
    safeEmit(const BaseState.loading()) ;
    final result = await _authRepository.login( email, password);
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) => safeEmit(BaseState.success(r)),
    );
  }
  Future<void>loginWithMobile({required String mobile, OtpChannel channel = OtpChannel.sms})async{
    safeEmit(const BaseState.loading());
    final result = await _authRepository.sendOtp(channel: channel, phone: mobile) ;
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) => safeEmit(BaseState.success(r)),
    );
  }
}