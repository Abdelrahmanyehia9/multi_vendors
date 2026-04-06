
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum StockAvailability {
  inStock,
  outOfStock,
  onBackOrder;

  static const Map<StockAvailability, String> _map = {
    StockAvailability.inStock: "in_Stock",
    StockAvailability.outOfStock: "out_of_Stock",
    StockAvailability.onBackOrder: "on_back_order",
  };

  String get toDatabase => _map[this]!;

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
    low => "Only $stock left 🔥",
  };
}
