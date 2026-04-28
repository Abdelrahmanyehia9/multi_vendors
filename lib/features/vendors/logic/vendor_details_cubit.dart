import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';

import 'package:multi_vendor/features/vendors/data/model/vendor_details_model.dart';
import 'package:multi_vendor/features/vendors/data/repository/vendor_repository.dart';

class VendorDetailsCubit extends Cubit<BaseState<VendorDetailsModel>>{
  final VendorRepository _repository;
  VendorDetailsCubit(this._repository): super(const BaseState.initial());
  Future<void>getVendorDetails(int id)async{
    safeEmit(const BaseState.loading());
    final result = await _repository.getVendorDetails(id);
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) => safeEmit(BaseState.success(r)),
    );
  }

}