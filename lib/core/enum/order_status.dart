import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';

enum OrderStatus {
  pending  , cancelled, delivered ,  ;
  static const Map<OrderStatus,String>_map= {
    pending : "pending",
    cancelled : "cancelled",
    delivered : "delivered",
  };
  String get toDatabase => _map[this]??"pending";
  factory OrderStatus.fromDatabase(String status)=>_map.entries.firstWhereOrNull((element) => element.value == status)?.key??pending;
  String get title => switch(this){
    pending => AppStrings.orderPending.tr(),
    cancelled => AppStrings.orderCancelled.tr(),
    delivered => AppStrings.orderDelivered.tr(),
  };
  Color get color => switch(this){
    pending  => AppColors.primary,
    cancelled => AppColors.error,
    delivered => AppColors.success,
  };
  /// to separate tracking status from order status
}
enum TrackStatus{
  confirmed,processing,shipped,delivered;
  static const Map<TrackStatus,String>_map= {
    delivered : "delivered",
    processing : "processing",
    shipped : "shipped",
    confirmed : "confirmed",
  };
  String get toDatabase => _map[this]??"processing";
  factory TrackStatus.fromDatabase(String status)=>_map.entries.firstWhereOrNull((element) => element.value == status)?.key??processing;
  String get title => switch(this){
    confirmed => AppStrings.orderConfirmed.tr(),
    delivered => AppStrings.orderDelivered.tr(),
    processing => AppStrings.orderProcessing.tr(),
    shipped => AppStrings.orderShipped.tr(),
  };
  String get description => switch (this) {
    confirmed => AppStrings.orderConfirmedDescription.tr(),
    processing => AppStrings.orderProcessingDescription.tr(),
    shipped => AppStrings.orderShippedDescription.tr(),
    delivered => AppStrings.orderDeliveredDescription.tr(),
  };
  Color get color => switch(this){
     processing=> AppColors.primary,
    confirmed => AppColors.info,
    delivered => AppColors.success,
    shipped => AppColors.info700,
  };
}