import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/core/models/base_user_model.dart';
import 'package:multi_vendor/features/main/profile/data/repository/profile_repository.dart';

class EditProfileCubit extends Cubit<BaseState<Unit>>{
  final ProfileRepository _repository;
  EditProfileCubit(this._repository) : super(const BaseState.initial());
  Future<void> editProfile(BaseUserModel user)async{
  if(user == userCubit.user) return  safeEmit(state.copyWith(status: StateStatus.empty, version: DateTime.now().microsecondsSinceEpoch));
    safeEmit(const BaseState.loading());
    final result = await _repository.editUser(user);
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) => safeEmit(BaseState.success(r)),
    );


  }
}