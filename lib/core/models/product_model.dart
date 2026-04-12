import 'package:multi_vendor/core/enum/product_tags.dart';
import 'package:multi_vendor/core/models/price_model.dart';
import 'package:multi_vendor/core/models/rating_model.dart';
import 'package:multi_vendor/core/models/vendor_model.dart';
import 'package:multi_vendor/core/utils/helper/fake_data.dart';

import 'base_product_model.dart';

class ProductModel extends BaseProductModel {
  const ProductModel({
    super.id,
    super.rating,
    required super.name,
    required super.price,
    super.productTags,
    super.thumbnail,
    super.vendor,
  });

  factory ProductModel.fromJson(Map<String, dynamic>json)=>
      ProductModel(
        id: json['id'],
          name: json['name'],
          price: PriceModel.fromJson(json),
        productTags:json["tags"]== null ? null:  (json['tags'] as List)
            .map((e) => ProductTags.fromDatabase(e))
            .toList(),
        thumbnail: json['thumbnail'],
          vendor: json['vendor'] == null ? null : VendorModel.fromJson(json['vendor']),
           rating: json['rating'] == null ? null : RatingModel.fromJson(json['rating']),

      );
  factory ProductModel.fake()=>
      ProductModel(
          name: FakeData.fakeStringTitle,
          price: PriceModel.fake(),
        productTags:const [],
        thumbnail: FakeData.fakeImg,
          vendor: VendorModel.fake(),
           rating: RatingModel.fake(),

      );


}
