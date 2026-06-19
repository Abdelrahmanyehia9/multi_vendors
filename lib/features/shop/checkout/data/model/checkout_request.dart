import 'package:multi_vendor/core/extensions/data_type.dart';

import 'package:multi_vendor/features/main/profile/data/model/address_model.dart';
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
    "p_pay_id": paymentId,
    "p_receipt":  summery.toJson(),
    "p_address" : address?.toJson(),
    "p_estimated_delivery": estimatedDelivery.toIso8601String(),
    "p_items": items.map((e)=>e.toJson()).toList(),
    "p_coupon_used": coupon??{},
  }.withoutNulls;

}
