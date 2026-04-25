import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/text_styles.dart';
import 'gap.dart';

enum MessagesAlertType {
  orderSuccess,
  loginRequired,
  resetPasswordSuccess,
  promoSuccess,
  promoFailed,
  orderCancelled,
  orderDeleted;

  String get title => switch (this) {
    orderSuccess => "Order Successful",
    orderCancelled => "Order Cancelled",
    orderDeleted => "Order Deleted",
    loginRequired => "Login Required",
    resetPasswordSuccess => "Password Reset Successful",
    promoSuccess => "Promo Code Applied Successfully",
    promoFailed => "Promo Code Failed",
  };

  String get message => switch (this) {
    orderCancelled => "Your order has been cancelled successfully.",
    orderSuccess =>
      "We are happy to inform you that your purchase has been completed. Thank you for your trust in shopping at our store",
    loginRequired =>
      "You're just one step away! Sign in to access your account and pick up right where you left off.",
    resetPasswordSuccess =>
      "Your password has been reset successfully. You can now sign in with your new password.",
    promoSuccess => "Promo Code Applied Successfully",
    promoFailed => "Promo Code Failed",
    orderDeleted => "Your order has been deleted successfully.",
  };

  IconData get icon => switch (this) {
    loginRequired => Icons.login,
    promoFailed => Icons.error,
    _ => Icons.verified,
  };

  Color get color => switch (this) {
    promoFailed  || loginRequired=> AppColors.error,
     _ => AppColors.success,
  };
}

class MessageAlert extends StatelessWidget {
  final MessagesAlertType type;

  final TextStyle? titleStyle;
  final TextStyle? messageStyle;

  final String? customMessage;

  final String? customTitle;

  final double iconSize;

  const MessageAlert(
    this.type, {
    super.key,
    this.titleStyle,
    this.messageStyle,
    this.customTitle,
    this.customMessage,
    this.iconSize = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4.h,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(type.icon, color: type.color, size: iconSize.sp),
        Text(
          customTitle ?? type.title,
          textAlign: TextAlign.center,
          style: titleStyle ?? TextStyles.labelMedium,
        ),
        Gap.tiny(),
        Text(
          customMessage ?? type.message,
          textAlign: TextAlign.center,
          style: messageStyle ?? TextStyles.captionMedium,
        ),
      ],
    );
  }
}
