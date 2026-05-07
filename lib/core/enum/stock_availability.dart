
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';


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
    StockAvailability.inStock=>AppStrings.inStock.tr(),
    StockAvailability.outOfStock=>AppStrings.outOfStock.tr(),
    StockAvailability.onBackOrder=>AppStrings.onBackOrder.tr(),
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
  factory StockAvailability.fromCount(int count){
    return count > 0
        ? StockAvailability.inStock
        : StockAvailability.outOfStock;
  }
}

enum StockStatus {
  high,
  medium,
  low;
 static StockStatus fromCount(int count) {
    return count > 70
        ? high
        : count > 19
        ? medium
        : low;
  }
  Color get color => switch (this) {
    high => AppColors.success700,
    medium => AppColors.grey,
    low => AppColors.error700,
  };
  IconData? get icon => switch (this) {
    high => MvIcons.checkedOutlined,
   _=>null
  };
}
