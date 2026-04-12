import 'package:multi_vendor/core/utils/helper/fake_data.dart';

class PriceModel {
  final num price;
  final num? salePrice;
  final DateTime? saleStartDate;
  final DateTime? saleEndDate;
  PriceModel({
    required this.price,
     this.salePrice,
     this.saleStartDate,
     this.saleEndDate,
  });

  factory PriceModel.fromJson(Map<String ,dynamic>json) {
    final interval = json['sale_interval'] ;
    return PriceModel(
      price: json['price'],
      salePrice: json['price_before_discount'],
      saleStartDate: interval==null?null:DateTime.parse(interval['start']) ,
      saleEndDate: interval==null?null:DateTime.parse(interval['end']) ,
  );
  }


  factory PriceModel.fake()=>PriceModel(price: FakeData.fakeDouble);
  num get totalPrice => salePrice ?? price;
}

