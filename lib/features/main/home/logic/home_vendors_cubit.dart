import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/main/home/data/repository/home_repository.dart';
import 'package:multi_vendor/features/vendors/data/model/vendor_model.dart';

class HomeVendorsCubit extends Cubit<BaseState<List<VendorModel>>>{
  final HomeRepository _repository;
  HomeVendorsCubit(this._repository) : super(const BaseState.initial());
  Future<void>getAllVendors()async{
    safeEmit(const BaseState.loading());
    final result = await _repository.getVendors();
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) {
        if(r.isEmpty)return safeEmit(const BaseState.empty());
        safeEmit(BaseState.success(r));
      },
    );
  }



}