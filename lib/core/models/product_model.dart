import 'package:multi_vendor/core/models/price_model.dart';
import 'package:multi_vendor/core/models/rating_model.dart';
import 'package:multi_vendor/core/models/vendor_model.dart';

import 'base_product_model.dart';

class ProductModel extends BaseProductModel {
  const ProductModel({
    super.id,
    super.rating,
    required super.name,
    required super.price,
    super.thumbnail,
    super.vendor,
  });

  factory ProductModel.fromJson(Map<String, dynamic>json)=>
      ProductModel(
        id: json['id'],
          name: json['name'],
          price: PriceModel.fromJson(json['price']),
          thumbnail: json['thumbnail'],
          vendor: json['vendor'] == null ? null : VendorModel.fromJson(json['vendor']),
           rating: json['rating'] == null ? null : RatingModel.fromJson(json['rating']),

      );
}
