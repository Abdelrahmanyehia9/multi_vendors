import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/main/profile/data/repository/profile_repository.dart';
import 'package:multi_vendor/shared/data/models/address_model.dart';

class EditAddressCubit extends Cubit<BaseState<Unit>>{
  final ProfileRepository _repository ;
  EditAddressCubit(this._repository,) : super(const BaseState.initial());

  Future<void> editAddress(AddressModel address)async{
    if(address == userCubit.user?.address) return  safeEmit(BaseState.empty(version: DateTime.now().microsecondsSinceEpoch));
    safeEmit(const BaseState.loading());
    final result = await _repository.editAddress(address);
    result.fold(
          (l) => safeEmit(BaseState.failure(l)),
          (r) => safeEmit(BaseState.success(r)),
    );


  }

}