import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final GestureTapCallback? onTap;
  final String? tooltip;
  final Color? iconColor;
  final Color? backGroundColor;
  final double size;
  final bool enabled;
  final double? radius;
  final bool blurry;

  const AppIconButton({
    super.key,
    this.size = 20,
    this.tooltip,
    this.iconColor,
    this.radius ,
    this.backGroundColor,
    this.blurry = false,
    this.onTap,
    this.enabled = true,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final color = (backGroundColor ??
                (blurry
                    ? Colors.black26
                    : context.colors.surfaceContainerLowest.withAppOpacity(0.85)))
    ;
    return AppButton.icon(
      onPressed: onTap,
      borderRadius: radius?? Decorations.borderRadius8.r,
      isBlurEffect: blurry,
      toolTip: tooltip?.tr(),
      enabled: enabled,
      borderWidth: 0,
      fixedSize: Size(size * 1.8, size * 1.8),
      color: color,
      icon: Icon(
        icon,
        size: size.sp,
        color: iconColor ?? context.colors.surfaceContainerHigh,
      ),
    );
  }
}
