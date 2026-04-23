import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/utils/helper/fake_data.dart';

class CheckoutSummeryModel {
  final num subtotal;
  final num shipping;
  final num total;
  final num? discount;
  final num? tax;

  CheckoutSummeryModel({
    required this.subtotal,
    required this.shipping,
    required this.total,
    this.discount,
    this.tax,
  });

  factory CheckoutSummeryModel.fromJson(Map<String, dynamic>json)=>CheckoutSummeryModel(
    subtotal: json['subtotal'],
    total: json['total'],
    tax: json['taxes'],
    shipping: json['shipping']??0,
    discount: json['discount'],
  ) ;
  factory CheckoutSummeryModel.fake()=>CheckoutSummeryModel(
    subtotal: FakeData.fakeInt,
    shipping: FakeData.fakeInt,
    tax: FakeData.fakeInt,
    total: FakeData.fakeInt,
    discount: FakeData.fakeInt,
  );

  Map<String, dynamic> toJson()=>{
    "subtotal" : subtotal,
    "total" : total,
    "taxes" : tax,
    "discount" : discount,
    "shipping" : shipping,
  }.withoutNulls;

}


