import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:flutter/material.dart';
import '../data/model/products_filters_model.dart';
import '../data/repository/product_repository.dart';

enum ProductsFilters{
  price,
  rating,
  vendor,
  stock,
  tags,
  categories
}


class ProductsAllFiltersCubit extends Cubit<BaseState<ProductsFiltersModel>> {
  final ProductRepository _productRepository;
  ProductsAllFiltersCubit(this._productRepository) : super(const BaseState.initial());
  ProductsFiltersModel? _selectedFilters ;
  ValueNotifier<int?> totalProducts = ValueNotifier<int?>(null);
  Future<void> init([ProductsFiltersModel? initialFilters]) async {
    safeEmit(const BaseState.loading());
    final result = await _productRepository.getProductFilters(selectedFilters: initialFilters);
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) {
        _selectedFilters = initialFilters;
        totalProducts.value = r.totalProducts;
        safeEmit(BaseState.success(r));
      },
    );
  }
  Future<void> getFiltersByFilters()async{
    final result = await _productRepository.getProductFilters(
      selectedFilters: _selectedFilters,
    );
    result.fold(
      (_) {},
      (r) {
        totalProducts.value = r.totalProducts;
      }
    );
  }
  void setFilters(ProductsFiltersModel filters) {
    _selectedFilters = filters;
    safeEmit(state.copyWith(
      version: DateTime.now().microsecondsSinceEpoch
    ));
  }
  ProductsFiltersModel? get selectedFilters => _selectedFilters;
  List<ProductsFilters> excludeFilters = [];
}
