import 'package:equatable/equatable.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/models/price_model.dart';
import 'package:multi_vendor/core/models/variant_attributes_model.dart';



class VariantModel extends Equatable {
  final String? sku;
  final PriceModel? price;
  final int? inStock;
  final String? images;
  final List<VariantsAttributes>? attributes;

  const VariantModel({
    this.sku,
    this.images,
    this.price,
    this.attributes,
    this.inStock,
  });

  factory VariantModel.fromJson(Map<String, dynamic> json) => VariantModel(
    sku: json['sku'],
    price: json['price'] is Map
        ? PriceModel.fromJson(Map<String, dynamic>.from(json['price']))
        : PriceModel.fromJson(json),
    inStock: json['stock'],
    images: json['image_url'],
    attributes: json['attributes'] == null
        ? null
        : VariantsAttributes.fromAny(json['attributes']),
  );

  Map<String, dynamic> toJson() => {
    "sku": sku,
    "price": price?.toJson(),
    "stock": inStock,
    "image_url": images,
    "attributes": attributes?.map((e) => e.toJson()).toList(),
  }.withoutNulls;

  @override
  // TODO: implement props
  List<Object?> get props => [sku, price, inStock, images, attributes];
}


