import 'package:multi_vendor/core/enum/order_status.dart';
import 'package:multi_vendor/core/models/address_model.dart';
import 'package:multi_vendor/core/utils/helper/fake_data.dart';
import 'package:multi_vendor/features/payments/data/model/payment_response.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_model.dart';
import 'package:multi_vendor/features/shop/shared/model/checkout_model.dart';

class OrderModel {
  final int? id ;
  final String? userId;
  final DateTime? createdAt;
  final AddressModel? address ;
  final CheckoutSummeryModel? summery ;
  final PaymentResponse? payment;
  final List<CartModel>? items;
  final DateTime? estimatedDelivery;
  final String? couponUsed;
  final OrderStatus? status;

  OrderModel({
    this.id,
    this.userId,
     this.createdAt,
     this.payment,
     this.items,
     this.estimatedDelivery,
     this.summery,
    this.address,
    this.couponUsed,
    this.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['user_id'],
      status: json['status'] == null ? null : OrderStatus.fromDatabase(json['status']),
      payment:json['payments']==null? null:  PaymentResponse.fromJson(json['payments']),
      createdAt:json['created_at']==null?null:  DateTime.parse(json['created_at']) ,
      summery: json['receipt'] == null ? null : CheckoutSummeryModel.fromJson(json['receipt']),
      address: json['address'] != null
          ? AddressModel.fromJson(json['address'])
          : null,
      estimatedDelivery:
          json["estimated_delivery"] ==null ? null :
      DateTime.parse(json['estimated_delivery']),
      items: json['items'] == null ? null : (json['items'] as List)
          .map((e) => CartModel.fromJson(e))
          .toList(),
      couponUsed: json['coupon_used'],
    );
  }
  factory OrderModel.fake() {
    return OrderModel(
      id: FakeData.fakeInt,
      userId: FakeData.fakeStringTitle,
      payment: PaymentResponse.fake(),
      createdAt:FakeData.fakeDateTime,
      summery:  CheckoutSummeryModel.fake(),
      address: AddressModel.fake(),
      estimatedDelivery: FakeData.fakeDateTime,
      items: List<CartModel>.generate(3, (index) => CartModel.fake()),
      couponUsed: "NONE"
    );
  }


  String get orderIdDisplay =>id == null ? "" : "ORDER-#$id";
}
