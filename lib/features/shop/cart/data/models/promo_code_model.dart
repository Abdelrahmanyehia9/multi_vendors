import 'package:collection/collection.dart';

enum PromoCodeType {
  fixed,
  percentage,
  freeShipping,
  ;

  static const Map<PromoCodeType, String> _map = {
    fixed: "fixed",
    percentage: "percentage",
    freeShipping: "free_shipping",
  };

  static PromoCodeType fromDatabase(String? data) =>
      _map.entries.firstWhereOrNull((element) => element.value == data)?.key ??
      PromoCodeType.fixed;

  String get toDatabase => _map[this] ?? "fixed";
}

class PromoCardResponse {
  final bool valid;
  final String? message;
  final CouponInfo? couponInfo;
  const PromoCardResponse({
    required this.valid,
     this.message,
     this.couponInfo,
  });
  factory PromoCardResponse.fromJson(Map<String, dynamic> json) => PromoCardResponse(
    valid: json['valid'],
    message: json['message'],
    couponInfo: json['coupon'] == null ? null : CouponInfo.fromJson(json['coupon']),
  );
  Map<String, dynamic> toJson() => {
    'valid': valid,
    'message': message,
    'couponInfo': couponInfo?.toJson(),
  };
}

class CouponInfo {
  final int? id;
  final String code;
  final String description;
  final num discount;
  final PromoCodeType type;

  const CouponInfo({
    this.id,
    required this.code,
    required this.description,
    required this.discount,
    required this.type,
  });

  factory CouponInfo.fromJson(Map<String, dynamic> json) => CouponInfo(
    id: json['id'],
    code: json['code'],
    description: json['description'],
    discount: json['discount'],
    type: PromoCodeType.fromDatabase(json['type']),
  );
  Map<String, dynamic>toJson()=>{
    'id': id,
    'code': code,
    'description': description,
    'discount': discount,
    'type': type.toDatabase,
  };

  String get message => "promo $code is Applied To your Order with $discount ${type == PromoCodeType.fixed ? " USD" : "%"} Enjoy yor order" ;
}
