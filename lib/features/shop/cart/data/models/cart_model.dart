import 'package:multi_vendor/core/extensions/data_type.dart';
import 'cart_product_model.dart';




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
