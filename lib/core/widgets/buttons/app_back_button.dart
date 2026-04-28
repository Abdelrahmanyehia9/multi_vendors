import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';

import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/widgets/buttons/app_icon_button.dart';

class AppBackButton extends StatelessWidget {
  final Color? iconColor;
  final Color? backgroundColor;
  final GestureTapCallback? onBack;

  const AppBackButton({
    super.key,
    this.onBack,
    this.iconColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 16.w, top: 16.h),
      child: AppIconButton(
        icon: Icons.arrow_back,
        size: 24,
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
