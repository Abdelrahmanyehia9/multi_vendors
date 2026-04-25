import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import '../../service/navigation_service.dart';
import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';
import '../gap.dart';

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
                  Text(title, style:titleStyle?? TextStyles.labelSmall),
                  Text(message,maxLines: 2 ,style: messageStyle?? TextStyles.captionLarge),
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
    required String message, String title = "تمت العمليه ينجاح"}) {
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
      icon: Icons.check,
    );
  }
  static void error({
    required BuildContext  context,
    required String message, String title = "حدث خطأ"}) {
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
      icon: Icons.error,
    );
  }
  static void warning({
    required BuildContext context,
    required String message, String title = "تحذير"}) {
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
      icon: Icons. warning,
    );
  }
}
