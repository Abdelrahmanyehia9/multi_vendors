// ignore_for_file: constant_identifier_names

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';

enum NotificationTemplates {
 order_shipped,
  order_delivered ,
  order_cancelled ,
  payment_successful,
  payment_failed,
  welcome,
  account_verified ,
  password_changed,
  promo_offer ;

  static NotificationTemplates? fromString(String? name) {
   if(name==null) return null;
    return NotificationTemplates.values.firstWhereOrNull((element) => element.name == name);
  }

  String toJson() => name;
IconData get icon => switch(this){
order_shipped => MvIcons.shipping ,
order_delivered => MvIcons.checkedOutlined,
order_cancelled => MvIcons.close,
_=> MvIcons.notification
};
Color get color => switch(this){
order_shipped || order_delivered => AppColors.success ,
order_cancelled =>AppColors.error,
_=> AppColors.primary
};

}