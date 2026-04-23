import 'package:multi_vendor/core/enum/stock_availability.dart';

class StockAvailabilityModel {
  final int quantity;
  StockAvailabilityModel({
    required this.quantity,
  });
  String get message => switch (quantity) {
    > 20 => "$quantity In Stock",
    _ => "Only $quantity left 🔥",
  };
  StockAvailability get type => StockAvailability.fromCount(quantity) ;
  StockStatus get status => StockStatus.fromCount(quantity);
}
