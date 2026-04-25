import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';

import '../data/model/vendor_details_model.dart';
import '../data/repository/vendor_repository.dart';

class VendorsByCategoryCubit extends Cubit<BaseState<List<VendorDetailsModel>>> {
  final VendorRepository _repo;
  VendorsByCategoryCubit(this._repo) : super(const BaseState.initial());


  Future<void>getVendorsByXCategory(int catID)async{
    safeEmit(const BaseState.loading());
    final result = await _repo.getVendorsByCategory(catID);
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) {
        if(r.isEmpty)return safeEmit(const BaseState.empty());
        safeEmit(BaseState.success(r));
      },
    );
  }
}