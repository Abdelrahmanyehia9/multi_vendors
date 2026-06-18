import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/gap.dart';


enum MessagesAlertType {
  orderSuccess,
  loginRequired,
  resetPasswordSuccess,
  promoSuccess,
  promoFailed,
  orderCancelled,
  reviewSubmitted,
  versionNotSupported,
  networkError,
  error,
  maintenance,
  orderDeleted;

  String get title => switch (this) {
    orderSuccess => AppStrings.orderSuccess.tr(),
    networkError => AppStrings.networkError.tr(),
    versionNotSupported => AppStrings.versionNotSupported.tr(),
    orderCancelled => AppStrings.orderCancelled.tr(),
    orderDeleted => AppStrings.orderDeleted.tr(),
    maintenance => AppStrings.maintenance.tr(),
    loginRequired => AppStrings.loginRequired.tr(),
    resetPasswordSuccess => AppStrings.resetPasswordSuccess.tr(),
    promoSuccess => AppStrings.promoSuccess.tr(),
    promoFailed => AppStrings.promoFailed.tr(),
    reviewSubmitted => AppStrings.reviewSubmitted.tr(),
    error => AppStrings.error.tr(),
  };

  String get message => switch (this) {
    networkError => AppStrings.networkErrorDescription.tr(),
    maintenance => AppStrings.maintenanceDescription.tr(),
    orderCancelled => AppStrings.orderCancelledDescription.tr(),
    orderSuccess => AppStrings.orderSuccessDescription.tr(),
    loginRequired => AppStrings.loginRequiredDescription.tr(),
    versionNotSupported => AppStrings.versionNotSupportedDescription.tr(),
    resetPasswordSuccess => AppStrings.resetPasswordSuccessDescription.tr(),
    promoSuccess => AppStrings.promoSuccessDescription.tr(),
    promoFailed => AppStrings.promoFailedDescription.tr(),
    orderDeleted => AppStrings.orderDeletedDescription.tr(),
    reviewSubmitted => AppStrings.reviewSubmittedDescription.tr(),
    error => AppStrings.errorDescription.tr(),
  };

  IconData get icon => switch (this) {
    loginRequired => MvIcons.login,
    promoFailed || error || versionNotSupported => MvIcons.error,
    maintenance => MvIcons.maintenance,
    _ => MvIcons.verified,

  };

  Color get color => switch (this) {
    promoFailed  || loginRequired || versionNotSupported => AppColors.error,
    maintenance => AppColors.warning,
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
  final Widget? customIcon ;

  const MessageAlert(
    this.type, {
    super.key,
    this.titleStyle,
    this.messageStyle,
    this.customTitle,
    this.customMessage,
    this.iconSize = 105,
        this.customIcon
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4.h,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        customIcon ??Icon(type.icon, color: type.color, size: iconSize.sp),
        Gap.medium(),
        Text(
          customTitle ?? type.title,
          textAlign: TextAlign.center,
          style: titleStyle ?? TextStyles.labelMedium,
        ),
        Text(
          customMessage ?? type.message,
          textAlign: TextAlign.center,
          style: messageStyle ?? TextStyles.captionMedium,
        ),
        Gap.medium()
      ],
    );
  }
}
