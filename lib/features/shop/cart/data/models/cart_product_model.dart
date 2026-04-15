import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/features/shop/product/data/model/product_details_model.dart';

import '../../../../../core/models/variant_model.dart';

class CartProductModel{
  final int? id;
  final String? name;
  final String? image;
  final VariantModel? variant;

  const CartProductModel({
     this.id,
     this.name,
     this.image,
    this.variant,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json)=>CartProductModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
       variant:  json['variant'] == null ? null : VariantModel.fromJson(json['variant'] as Map<String, dynamic>),
  )  ;
  Map<String, dynamic> toJson()=>{
    'id': id,
    "name":name,
    "image":image,
    "variant":variant?.toJson()
  }.withoutNulls ;
  factory CartProductModel.fromProductModel(ProductDetailsModel v, {VariantModel? selectedVariant})=>CartProductModel(
      id: v.id,
      name: v.name,
      image:selectedVariant?.images?? v.thumbnail,
      variant: selectedVariant
  ) ;

  String get uniqueId => "${id}_${variant?.sku}_${variant?.attributes?.join("_")}";
}
