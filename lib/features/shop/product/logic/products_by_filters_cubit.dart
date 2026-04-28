import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';

import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/features/shop/product/data/model/products_filters_model.dart';
import 'package:multi_vendor/features/shop/product/data/model/products_response_model.dart';
import 'package:multi_vendor/features/shop/product/data/repository/product_repository.dart';

class ProductsByFiltersCubit extends Cubit<BaseState<ProductResponseModel>> {
  final ProductRepository _productRepository;
  ProductsByFiltersCubit(this._productRepository) : super(const BaseState.initial());

  Future<void>getProductsInFilter({ProductsFiltersModel? filters})async{
    safeEmit(const BaseState.loading());
    final result = await _productRepository.getProductInFilters(selectedFilters: filters);
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) {
        if(r.products.isEmpty) return safeEmit(const BaseState.empty());
        safeEmit(BaseState.success(r));
      },
    );
  }
}