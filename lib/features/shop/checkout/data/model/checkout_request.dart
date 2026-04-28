import 'package:multi_vendor/core/extensions/data_type.dart';

import 'package:multi_vendor/shared/data/models/address_model.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_model.dart';
import 'package:multi_vendor/features/shop/shared/model/checkout_model.dart';

class CheckoutRequest {
  final AddressModel? address ;
  final CheckoutSummeryModel summery ;
  final int paymentId;
  final List<CartModel> items;
  final DateTime estimatedDelivery;
  final String? coupon;

  CheckoutRequest({
    required this.paymentId,
    required this.items,
    required this.estimatedDelivery,
    required this.summery,
    this.address,
    this.coupon,
  });

  Map<String, dynamic> toJson()=> {
    "pay_id": paymentId,
    "receipt":  summery.toJson(),
    "address" : address?.toJson(),
    "estimated_delivery": estimatedDelivery.toIso8601String(),
    "items": items.map((e)=>e.toJson()).toList(),
    "coupon_used": coupon,
  }.withoutNulls;

}
