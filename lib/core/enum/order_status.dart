import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';

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
    pending => "Pending",
    cancelled => "Cancelled",
    delivered => "Delivered",
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
    confirmed => "Confirmed",
    delivered => "Delivered",
    processing => "Processing",
    shipped => "Shipped",
  };
  String get description => switch (this) {
    confirmed => "Your order has been confirmed and will be prepared shortly",
    processing => "We are currently preparing your order",
    shipped => "Your order is on the way to your location",
    delivered => "Your order has been delivered successfully",
  };
  Color get color => switch(this){
     processing=> AppColors.primary,
    confirmed => AppColors.info,
    delivered => AppColors.success,
    shipped => AppColors.info700,
  };
}