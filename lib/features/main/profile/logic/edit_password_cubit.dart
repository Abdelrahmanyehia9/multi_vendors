import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/main/profile/data/repository/profile_repository.dart';

import '../../../../core/cubit/base_state.dart';

class EditPasswordCubit extends Cubit<BaseState<Unit>>{
  final ProfileRepository _repository ;
  EditPasswordCubit(this._repository) : super(const BaseState.initial());


  Future<void>editPassword(String password)async{
    safeEmit(const BaseState.loading()) ;
    final result = await _repository.editProfile(password: password);
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) => safeEmit(BaseState.success(r)),
    );
  }


}