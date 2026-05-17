import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';

import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/buttons/app_icon_button.dart';

class AppBackButton extends StatelessWidget {
  final Color? iconColor;
  final Color? backgroundColor;
  final GestureTapCallback? onBack;
  final double size ;
  final double padding ;

  const AppBackButton({
    super.key,
    this.onBack,
    this.iconColor,
    this.backgroundColor,
    this.size =24,
    this.padding =16
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: padding.w, top: padding.h),
      child: AppIconButton(
        icon: MvIcons.arrowBack,
        size: size,
        tooltip: AppStrings.back,
        iconColor: iconColor,
        backGroundColor: backgroundColor,
        onTap:
        onBack ??
                () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.pushNamedAndRemoveUntil(
                  Routes.mainLayout,
                  predicate: (_) => false,
                );
              }
            },
      ),
    );
  }
}
