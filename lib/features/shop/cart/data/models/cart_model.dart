import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/utils/helper/fake_data.dart';
import '../../../../../core/models/price_model.dart';
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
  factory CartModel.fake()=>CartModel(
    quantity: FakeData.fakeInt,
    product: CartProductModel.fake(),
  );

  Map<String, dynamic> toJson()=>{
    'quantity': quantity,
    'product': product.toJson(),
  }.withoutNulls;

  num get total => quantity * product.priceModel.totalPrice;

}

class CartProductModel{
  final int? id;
  final String? name;
  final String? image;
  final PriceModel price;
  final int inStock;

  const CartProductModel({
    this.id,
    this.name,
    this.image,
    required this.price,
    required this.inStock,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json)=>CartProductModel(
    id: json['id'],
    name: json['name'],
    image: json['image'],
    price: PriceModel.fromJson(json),
    inStock: json['in_stock'],
  )  ;
  factory CartProductModel.fake()=>CartProductModel(
    id:FakeData.fakeInt,
    name: FakeData.fakeStringTitle,
    image: FakeData.fakeImg,
    price: PriceModel.fake(),
    inStock: FakeData.fakeInt,
  )  ;
  Map<String, dynamic> toJson()=>{
    'id': id,
    "name":name,
    "image":image,
    ...price.toJson(),
    'in_stock': inStock,
  }.withoutNulls ;
  factory CartProductModel.fromProductModel(ProductDetailsModel v)=>CartProductModel(
      id: v.id,
      name: v.name,
      price: v.price,
      image:v.thumbnail,
       inStock: v.inStock?.quantity??0
  ) ;

  PriceModel get priceModel => price ;
  int get uniqueId => id!;
}



extension CartEXT on List<CartModel>{
  num get totalPrice => fold<num>(
    0,
        (sum, item) =>
    sum + (item.product.priceModel.price * item.quantity),
  );
}
