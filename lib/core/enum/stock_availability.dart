
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum StockAvailability {
  inStock,
  outOfStock,
  onBackOrder;

  static const Map<StockAvailability, String> _map = {
    StockAvailability.inStock: "in_stock",
    StockAvailability.outOfStock: "out_of_stock",
    StockAvailability.onBackOrder: "on_back_order",
  };

  String get toDatabase => _map[this]!;

  String get toText=>switch(this){
    StockAvailability.inStock=>"In Stock",
    StockAvailability.outOfStock=>"Out of Stock",
    StockAvailability.onBackOrder=>"On Back Order",
  };

  Color get color => switch (this) {
    StockAvailability.inStock => AppColors.success700,
    StockAvailability.outOfStock => AppColors.error700,
    StockAvailability.onBackOrder => AppColors.grey,
  };

  factory StockAvailability.fromDatabase(String value) {
    return _map.entries
            .firstWhereOrNull((entry) => entry.value == value)
            ?.key ??
        StockAvailability.inStock;
  }
}

enum StockCountStatus {
  high,
  medium,
  low;

 static StockCountStatus fromInt(int count) {
    return count > 70
        ? StockCountStatus.high
        : count > 19
        ? StockCountStatus.medium
        : StockCountStatus.low;
  }

  Color get color => switch (this) {
    high => AppColors.success700,
    medium => AppColors.grey,
    low => AppColors.error700,
  };

  IconData? get icon => switch (this) {
    high => Icons.check_circle,
   _=>null
  };

  String message(int stock) => switch (this) {
    high || medium => "$stock In Stock",
    low => stock == 0 ? "Out of Stock": "Only $stock left 🔥",
  };
}
