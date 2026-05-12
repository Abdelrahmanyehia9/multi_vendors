import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';

import 'package:multi_vendor/core/widgets/buttons/app_button.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final GestureTapCallback? onTap;
  final String? tooltip;
  final Color? iconColor;
  final Color? backGroundColor;
  final double size;
  final bool enabled ;
  final double radius ;

  const AppIconButton({
    super.key,
    this.size = 20,
    this.tooltip,
    this.iconColor,
    this.radius = 8,
    this.backGroundColor,
    this.onTap,
    this.enabled = true,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton.icon(
      onPressed: onTap,
      borderRadius: radius,
      toolTip: tooltip?.tr(),
      enabled: enabled,
      fixedSize: Size(size * 1.8, size * 1.8),
      color: backGroundColor ?? context.colors.surfaceContainerLowest,
      icon: Icon(
        icon,
        size: size.sp,
        color: iconColor ?? context.colors.surfaceContainerHigh,
      ),
    );
  }
}
