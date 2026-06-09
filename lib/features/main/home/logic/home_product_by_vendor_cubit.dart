import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/main/home/data/repository/home_repository.dart';
import 'package:multi_vendor/shared/data/models/product_model.dart';

class HomeProductByVendorCubit extends Cubit<BaseState<List<ProductModel>>>{
  final HomeRepository _repository ;
  HomeProductByVendorCubit(this._repository):super(const BaseState.initial()) ;

  Future<void>getProducts({required int vendorId})async{
    safeEmit(const BaseState.loading());
    final result = await _repository.getProductsByVendor(vendorId);
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) {
        if(r.isEmpty) return safeEmit(const BaseState.empty());
        safeEmit(BaseState.success(r));
      },
    );
  }
}