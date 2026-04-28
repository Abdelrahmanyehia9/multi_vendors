import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';

import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/features/authentication/data/repository/reset_password_repository.dart';

class ForgetPasswordChangePasswordCubit extends Cubit<BaseState<Unit>>{
  final ResetPasswordRepository _repository ;
  ForgetPasswordChangePasswordCubit(this._repository):super(const BaseState.initial());
  Future<void>  changePassword({required String newPassword})async{
    safeEmit(const BaseState.loading());
    final result = await _repository.changePassword(newPassword) ;
    result.fold(
          (l) => safeEmit(BaseState.failure(l)),
          (r) => safeEmit(BaseState.success(r)),
    );

  }


}