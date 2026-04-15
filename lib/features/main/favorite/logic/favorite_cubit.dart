import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/core/models/product_model.dart';
import 'package:multi_vendor/core/models/vendor_model.dart';
import 'package:multi_vendor/features/main/favorite/data/model/favorite_model.dart';
import 'package:multi_vendor/features/main/favorite/data/repository/favorite_repository.dart';

class FavoriteCubit extends Cubit<BaseState<FavoriteModel>> {
  final FavoriteRepository _repository;

  FavoriteModel favoriteModel =
  FavoriteModel(favoriteProducts: [], favoriteVendors: []);

  FavoriteCubit(this._repository) : super(const BaseState.initial());

  Future<void> init() async {
    safeEmit(const BaseState.loading());
    final result = await _repository.getFavorite();
    result.fold(
          (l) => safeEmit(BaseState.failure(l)),
          (r) {
        favoriteModel = r;
        safeEmit(BaseState.success(r));
      },
    );
  }

  Future<void> toggleFavorite({
    required bool isProduct,
    ProductModel? product,
    VendorModel? vendor,
  }) async {
    final updated = _toggleLocal(
      isProduct: isProduct,
      product: product,
      vendor: vendor,
    );
    await _update(updatedModel: updated);
  }

  Future<void> _update({
    required FavoriteModel updatedModel,
  }) async {
    favoriteModel = updatedModel;
    safeEmit(BaseState.success(updatedModel));
    await _repository.updateFavorite(updatedModel);
  }

  FavoriteModel _toggleLocal({
    required bool isProduct,
    ProductModel? product,
    VendorModel? vendor,
  }) {
    final products = List<ProductModel>.from(favoriteModel.favoriteProducts);
    final vendors = List<VendorModel>.from(favoriteModel.favoriteVendors);

    if (isProduct && product != null) {
      final exists = products.any((e) => e.id == product.id);
      exists
          ? products.removeWhere((e) => e.id == product.id)
          : products.add(product);
    }

    if (!isProduct && vendor != null) {
      final exists = vendors.any((e) => e.id == vendor.id);
      exists
          ? vendors.removeWhere((e) => e.id == vendor.id)
          : vendors.add(vendor);
    }

    return favoriteModel.copyWith(
      favoriteProducts: products,
      favoriteVendors: vendors,
    );
  }

  bool isInFavorite({
    required int id,
    required bool isProduct,
  }) {
    return isProduct
        ? favoriteModel.favoriteProducts.any((e) => e.id == id)
        : favoriteModel.favoriteVendors.any((e) => e.id == id);
  }
}