import 'package:multi_vendor/core/extensions/data_type.dart';

import '../../../cart/data/models/promo_code_model.dart';
import '../checkout_model.dart';

extension CheckoutSummeryModelExtension on CheckoutSummeryModel {
  String get subTotalDisplay => subtotal.usdPrice ;
  String get totalDisplay => total.usdPrice ;
  String?  shippingDisplay(CouponInfo? promo)=>promo?.type == PromoCodeType.freeShipping  || shipping == 0 ? "FREE": shipping.usdPrice;
  String? get taxDisplay=>tax?.usdPrice;
  String? get discountDisplay=>discount == 0 || discount == null ?null:"-${discount!.usdPrice}";
}