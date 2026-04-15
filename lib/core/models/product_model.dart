import 'package:multi_vendor/core/enum/product_tags.dart';
import 'package:multi_vendor/core/models/price_model.dart';
import 'package:multi_vendor/core/models/rating_model.dart';
import 'package:multi_vendor/core/models/vendor_model.dart';
import 'package:multi_vendor/core/utils/helper/fake_data.dart';
import 'package:multi_vendor/features/shop/product/data/model/product_details_model.dart';

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
          price: json['price'] is Map ? PriceModel.fromJson(json['price']): PriceModel.fromJson(json),
        productTags:json["tags"]== null ? null:  (json['tags'] as List)
            .map((e) => ProductTags.fromDatabase(e))
            .toList(),
        thumbnail: json['thumbnail'],
          vendor: json['vendor'] == null ? null : VendorModel.fromJson(json['vendor']),
           rating: json['rating'] == null ? null : RatingModel.fromJson(json['rating']),

      );
  factory ProductModel.fake()=>
      ProductModel(
        id: FakeData.fakeInt,
          name: FakeData.fakeStringTitle,
          price: PriceModel.fake(),
        productTags:const [],
        thumbnail: FakeData.fakeImg,
          vendor: VendorModel.fake(),
           rating: RatingModel.fake(),

      );


  Map<String, dynamic>toJson()=>{
    'id':id,
    "name":name,
    "price":price?.toJson(),
    "tags":productTags?.map((e) => e.toDatabase).toList(),
    "thumbnail":thumbnail,
    "vendor":vendor?.toJson(),
    "rating":rating?.toJson(),
  };


 factory ProductModel.fromProductDetails(ProductDetailsModel model)=>ProductModel(
      name: model.name,
     price: model.price ,
    id: model.id,
    thumbnail: model.thumbnail,
    vendor: model.vendor,
    rating: model.rating,
   productTags: model.productTags,

 );

}
