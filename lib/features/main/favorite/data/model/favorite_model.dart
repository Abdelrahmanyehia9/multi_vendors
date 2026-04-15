import 'package:multi_vendor/core/models/vendor_model.dart';

import '../../../../../core/models/product_model.dart';

class FavoriteModel {
  final List<ProductModel> favoriteProducts;
  final List<VendorModel> favoriteVendors;

  FavoriteModel({
    required this.favoriteProducts,
    required this.favoriteVendors,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) =>
      FavoriteModel(
        favoriteProducts: (json['products'] as List? ?? [])
            .map((x) => ProductModel.fromJson(x))
            .toList(),
        favoriteVendors: (json['vendors'] as List? ?? [])
            .map((x) => VendorModel.fromJson(x))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    'products': favoriteProducts.map((x) => x.toJson()).toList(),
    'vendors': favoriteVendors.map((x) => x.toJson()).toList(),
  };

  FavoriteModel copyWith({
    List<ProductModel>? favoriteProducts,
    List<VendorModel>? favoriteVendors,
  }) =>
      FavoriteModel(
        favoriteProducts: favoriteProducts ?? this.favoriteProducts,
        favoriteVendors: favoriteVendors ?? this.favoriteVendors,
      );
}