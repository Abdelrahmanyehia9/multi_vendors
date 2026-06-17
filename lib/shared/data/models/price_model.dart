import 'package:multi_vendor/core/utils/helper/fake_data.dart';

class PriceModel {
  final num price;
  final num? priceBeforeDiscount;
  final DateTime? saleStartDate;
  final DateTime? saleEndDate;
  PriceModel({
    required this.price,
     this.priceBeforeDiscount,
     this.saleStartDate,
     this.saleEndDate,
  });

  factory PriceModel.fromJson(Map<String ,dynamic>json) {
    final interval = json['sale_interval'] ;
    return PriceModel(
      price: json['price'],
      priceBeforeDiscount: json['price_before_discount'],
      saleStartDate: interval==null?null:DateTime.parse(interval['start']) ,
      saleEndDate: interval==null?null:DateTime.parse(interval['end']) ,
  );
  }

  Map<String, dynamic> toJson() => {
    "price": price,
    "price_before_discount": priceBeforeDiscount,
    "sale_interval": (saleStartDate != null || saleEndDate != null)
        ? {
      "start": saleStartDate?.toIso8601String(),
      "end": saleEndDate?.toIso8601String(),
    }
        : null,
  };
  factory PriceModel.fake()=>PriceModel(price: FakeData.fakeDouble);
  num get totalPrice => price;
  num get discountPercentage =>
    priceBeforeDiscount != null && priceBeforeDiscount! > price
        ? ((priceBeforeDiscount! - price) / priceBeforeDiscount!) * 100
        : 0;
  bool get isOnSale {
    if (priceBeforeDiscount == null) return false;
    if (saleStartDate == null || saleEndDate == null) {
      return true;
    }
    final now = DateTime.now();
    return now.isAfter(saleStartDate!) && now.isBefore(saleEndDate!);
  }}

