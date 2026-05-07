import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/service/navigation_service.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/gap.dart';

class SnackBars {
  const SnackBars._();
  static void custom(
    String message, {
    Color backgroundColor = AppColors.primary,
    Color borderColor = Colors.transparent,
    String title = "",
    IconData? icon,
    bool showPattern = true,
    bool showGradient = true,
    bool hasTitle = true,
    TextStyle ? titleStyle ,
    TextStyle ? messageStyle ,
    required BuildContext context ,
    Duration duration = const Duration(milliseconds: 1200),
  })
  {

    final snackBar = SnackBar(
      elevation: 0,
      padding: EdgeInsets.zero,
     backgroundColor: Colors.transparent,
      content: AnimatedContainer(
        duration: duration,
        curve: Curves.bounceOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          gradient: showGradient ?  LinearGradient(
            colors: [backgroundColor, backgroundColor.darken(0.05)],
          ) :null,
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white),
              const Gap(12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(hasTitle)
                  Text(title.tr(), style:titleStyle?? TextStyles.labelSmall),
                  Text(message.tr(),maxLines: 2 ,style: messageStyle?? TextStyles.captionLarge),
                ],
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor),
      ),
      duration: duration,
      behavior: SnackBarBehavior.fixed,
    );
    ScaffoldMessenger.of(NavigationService.context!).showSnackBar(
      snackBar,
      snackBarAnimationStyle: const AnimationStyle(
        curve: Curves.bounceIn,
        reverseCurve: Curves.bounceOut,
        duration: Duration(milliseconds: 600),
      ),
    );
  }

  static void success({
    required BuildContext context,
    required String message, String title = AppStrings.operationDidSuccessfully}) {
    custom(
      message,
      context: context,
      titleStyle: TextStyles.labelSmall.copyWith(
        color: Colors.white
      ),
      messageStyle: TextStyles.captionLarge.copyWith(
        color: Colors.white
      ),
      backgroundColor: AppColors.success600,
      title: title,
      icon: MvIcons.checked,
    );
  }
  static void error({
    required BuildContext  context,
    required String message, String title = AppStrings.errorOccurred}) {
    custom(
      message,
      context: context,
      backgroundColor: AppColors.error,
      title: title,
      titleStyle: TextStyles.labelSmall.copyWith(
          color: Colors.white
      ),
      messageStyle: TextStyles.captionLarge.copyWith(
          color: Colors.white
      ),
      icon: MvIcons.error,
    );
  }
  static void warning({
    required BuildContext context,
    required String message, String title = AppStrings.warning}) {
    custom(
      message,
      context: context,
      backgroundColor: AppColors.warning,
      title: title,
      titleStyle: TextStyles.labelSmall.copyWith(
          color: Colors.white
      ),
      messageStyle: TextStyles.captionLarge.copyWith(
          color: Colors.white
      ),
      icon: MvIcons. warning,
    );
  }
}
