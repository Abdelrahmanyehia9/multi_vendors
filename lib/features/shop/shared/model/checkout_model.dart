import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/utils/helper/fake_data.dart';
import 'package:multi_vendor/features/shop/cart/data/models/promo_code_model.dart';

class CheckoutSummeryModel {
  final num subtotal;
  final num? shipping;
  final num total;
  final num? discount;
  final num? tax;

  CheckoutSummeryModel({
    required this.subtotal,
    this.shipping,
    required this.total,
    this.discount,
    this.tax,
  });

  factory CheckoutSummeryModel.fromJson(Map<String, dynamic>json)=>CheckoutSummeryModel(
    subtotal: json['subtotal'],
    total: json['total'],
    tax: json['taxes'],
    shipping: json['shipping'],
    discount: json['discount'],
  ) ;
  factory CheckoutSummeryModel.fake()=>CheckoutSummeryModel(
    subtotal: FakeData.fakeInt,
    shipping: FakeData.fakeInt,
    tax: FakeData.fakeInt,
    total: FakeData.fakeInt,
    discount: FakeData.fakeInt,
  );


   String get subTotalDisplay => subtotal.usdPrice ;
   String get totalDisplay => total.usdPrice ;
   String?  shippingDisplay(CouponInfo? promo)=>promo?.type == PromoCodeType.freeShipping? "FREE": shipping?.usdPrice;
   String? get taxDisplay=>tax?.usdPrice;
   String? get discountDisplay=>discount == 0 || discount == null ?"":"-${discount!.usdPrice}";
}
