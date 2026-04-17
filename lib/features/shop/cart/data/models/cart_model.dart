import 'package:multi_vendor/core/extensions/data_type.dart';
import '../../../../../core/models/price_model.dart';
import '../../../../../core/models/variant_model.dart';
import '../../../product/data/model/product_details_model.dart';

class CartModel {
  final CartProductModel product;
  final int quantity;

  CartModel({required this.product, required this.quantity});


  CartModel copyWith({int? quantity, CartProductModel? product})=>CartModel(
    quantity: quantity ?? this.quantity,
    product: product ?? this.product,
  );

  factory CartModel.fromJson(Map<String, dynamic> json)=>CartModel(
    quantity: json['quantity'],
    product: CartProductModel.fromJson(json['product'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson()=>{
    'quantity': quantity,
    'product': product.toJson(),
  }.withoutNulls;


}

class CartProductModel{
  final int? id;
  final String? name;
  final String? image;
  final VariantModel? variant;
  final PriceModel price;

  const CartProductModel({
    this.id,
    this.name,
    this.image,
    this.variant,
    required this.price
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json)=>CartProductModel(
    id: json['id'],
    name: json['name'],
    image: json['image'],
    price: PriceModel.fromJson(json),
    variant:  json['variant'] == null ? null : VariantModel.fromJson(json['variant'] as Map<String, dynamic>),
  )  ;
  Map<String, dynamic> toJson()=>{
    'id': id,
    "name":name,
    "image":image,
    "variant":variant?.toJson(),
    ...price.toJson()
  }.withoutNulls ;
  factory CartProductModel.fromProductModel(ProductDetailsModel v, {VariantModel? selectedVariant})=>CartProductModel(
      id: v.id,
      name: v.name,
      price: v.price,
      image:selectedVariant?.images?? v.thumbnail,
      variant: selectedVariant
  ) ;

  PriceModel get priceModel => variant?.price ?? price ;
  String get uniqueId => "${id}_${variant?.sku}_${variant?.attributes?.join("_")}";
}



extension CartEXT on List<CartModel>{
  num get totalPrice => fold<num>(
    0,
        (sum, item) =>
    sum + (item.product.priceModel.price * item.quantity),
  );
}
