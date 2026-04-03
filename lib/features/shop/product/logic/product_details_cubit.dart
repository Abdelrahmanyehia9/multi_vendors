import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/shop/product/data/model/product_details_model.dart';
import 'package:multi_vendor/features/shop/product/data/repository/product_repository.dart';

class ProductDetailsCubit extends Cubit<BaseState<ProductDetailsModel>>{
  final ProductRepository _repository ;
  ProductDetailsCubit(this._repository):super(const BaseState.initial()) ;


  Future<void> getProductDetails({required int pId})async{
    safeEmit(const BaseState.loading()) ;
    final result = await _repository.getSingleProduct(pId: pId) ;
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) => safeEmit(BaseState.success(r)),
    ) ;
  }
}