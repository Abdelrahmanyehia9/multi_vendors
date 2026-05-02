import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/main/profile/data/repository/profile_repository.dart';

class EditProfilePicCubit extends Cubit<BaseState<String>>{
  final ProfileRepository _repository  ;
  EditProfilePicCubit(this._repository) : super(const BaseState.initial());

  Future<void>add(String path)async{
    safeEmit(const BaseState.loading());
    final result = await _repository.addProfilePic(path);
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) => safeEmit(BaseState.success(r)),
    );
  }
  Future<void>remove()async{
    safeEmit(const BaseState.loading());
    final result = await _repository.removeProfilePic();
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) => safeEmit(BaseState.success(r)),
    );
  }

}