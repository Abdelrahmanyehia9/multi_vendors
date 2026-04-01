import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/core/models/base_user_model.dart';
import 'package:multi_vendor/features/authentication/data/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/repository/otp_repository.dart';

class LoginCubit extends Cubit<BaseState<Unit>> {
  final AuthRepository _authRepository;
  final OtpRepository _otpRepository;
  LoginCubit(this._authRepository, this._otpRepository) : super(const BaseState.initial());

  Future<void> login({required String email, required String password}) async {
    safeEmit(const BaseState.loading());
    final result = await _authRepository.login(email, password);
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) => safeEmit(BaseState.success(r)),
    );
  }

  Future<void> loginWithMobile({
    required String mobile,
    required Country country,
    OtpChannel channel = OtpChannel.sms,
  }) async {
    safeEmit(const BaseState.loading());
    final result = await _otpRepository.sendOtp(
      channel: channel,
      phone: country.dialCode+mobile,
      user: BaseUserModel(
        phone: mobile,
        country: country,
      )
    );
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) => safeEmit(BaseState.success(r)),
    );
  }
}
