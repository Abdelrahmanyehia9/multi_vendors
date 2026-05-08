import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/utils/helper/fake_data.dart';
import 'package:multi_vendor/shared/data/models/product_model.dart';

class CartModel {
  final ProductModel product;
  final int quantity;
  final bool? isRated ;
  final int? orderItemId;
  const CartModel({this.orderItemId,required this.product, this.isRated , required this.quantity});


  CartModel copyWith({int? quantity,bool? isRated, int? orderItemId   , ProductModel? product})=>CartModel(
    quantity: quantity ?? this.quantity,
    product: product ?? this.product,
    isRated: isRated ?? this.isRated,
    orderItemId: orderItemId ?? this.orderItemId,
  );

  factory CartModel.fromJson(Map<String, dynamic> json)=>CartModel(
    quantity: json['quantity'],
    product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
    isRated: json['is_rated'],
    orderItemId: json['order_item_id'],
  );
  factory CartModel.fake()=>CartModel(
    quantity: FakeData.fakeInt,
    product: ProductModel.fake(),
    isRated: FakeData.fakeBoolean,
  );

  Map<String, dynamic> toJson()=>{
    'quantity': quantity,
    'product': product.toJson(),
  }.withoutNulls;

  num get total => quantity * (product.price?.totalPrice??0);
}

extension CartEXT on List<CartModel>{
  num get totalPrice => fold<num>(
    0,
        (sum, item) =>
    sum + ((item.product.price?.price??0) * item.quantity),
  );
}
