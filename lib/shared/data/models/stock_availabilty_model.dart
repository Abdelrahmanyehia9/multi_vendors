import 'package:multi_vendor/core/enum/stock_availability.dart';

class StockAvailabilityModel {
  final int quantity;
  StockAvailabilityModel({
    required this.quantity,
  });

  StockAvailability get type => StockAvailability.fromCount(quantity) ;
  StockStatus get status => StockStatus.fromCount(quantity);
}
