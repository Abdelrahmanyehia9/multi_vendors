import 'package:multi_vendor/shared/data/models/product_model.dart';
import 'package:multi_vendor/features/vendors/data/model/vendor_model.dart';
import 'package:multi_vendor/features/main/favorite/data/model/favorite_item.dart';
import 'package:multi_vendor/features/main/favorite/data/model/favorite_model.dart';

extension FavoriteModelX on FavoriteModel {
  FavoriteModel toggle(FavoriteItem item) {
    final isProduct = item.favoriteType == FavoriteType.product;

    final products = List<ProductModel>.from(favoriteProducts);
    final vendors = List<VendorModel>.from(favoriteVendors);

    if (isProduct && item is ProductModel) {
      final exists = products.any((e) => e.id == item.id);
      exists
          ? products.removeWhere((e) => e.id == item.id)
          : products.add(item);
    }

    if (!isProduct && item is VendorModel) {
      final exists = vendors.any((e) => e.id == item.id);
      exists
          ? vendors.removeWhere((e) => e.id == item.id)
          : vendors.add(item);
    }

    return copyWith(
      favoriteProducts: products,
      favoriteVendors: vendors,
    );
  }
  bool containsItem(FavoriteItem item) {
    final id = item.favoriteId;

    return item.favoriteType == FavoriteType.product
        ? favoriteProducts.any((e) => e.id == id)
        : favoriteVendors.any((e) => e.id == id);
  }
}