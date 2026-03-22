import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/authentication/data/model/auth_user_model.dart';

import '../../../core/cubit/base_state.dart';
import '../data/repository/auth_repository.dart';

class SignupCubit extends Cubit<BaseState<Unit>> {
  final AuthRepository _authRepository;
  SignupCubit(this._authRepository) : super(const BaseState.initial());
  Future<void>signup({required String password ,required AuthUserModel user})async{
    safeEmit(const BaseState.loading());
    final result = await _authRepository.signUp(user.email!, password, user) ;
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) => safeEmit(BaseState.success(r)),
    );
  }

}