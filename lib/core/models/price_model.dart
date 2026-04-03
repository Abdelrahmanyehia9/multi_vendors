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

  factory PriceModel.fromJson(Map<String ,dynamic>json)=>PriceModel(
      price: json['price'],
      salePrice: json['sale_price'],
      saleStartDate: json['sale_start_date'],
      saleEndDate: json['sale_end_date'],
  );


  factory PriceModel.fake()=>PriceModel(price: FakeData.fakeDouble);

  num get totalPrice => salePrice ?? price;
}
