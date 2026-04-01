import 'package:multi_vendor/core/models/price_model.dart';
enum VariantType {
  color,
  size,
}



class VariantModel {
  final String value;
  final int available;
  final VariantType type;
  final PriceModel? price;

  VariantModel({
    required this.value,
    required this.type,
    required this.available,
    this.price,
  });
}
