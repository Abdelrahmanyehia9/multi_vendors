import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';

class AppChip extends StatelessWidget {
  final String text;
  final bool selected;
  final Color? unSelectedBorderColor;
  final Color? selectedBorderColor;
  final Color? selectedColor;
  final EdgeInsets? padding;
  final Color? labelColor;
  final Widget? child;
  final double? borderRadius;
  final Color? unselectedColor;
  final TextStyle? textStyle;

  const AppChip({
    super.key,
    required this.text,
    this.selected = false,
    this.unselectedColor,
    this.unSelectedBorderColor,
    this.selectedColor,
    this.labelColor,
    this.child,
    this.padding,
    this.textStyle,
    this.borderRadius,
    this.selectedBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = selected
        ? selectedColor ?? AppColors.primary
        : unselectedColor ?? Colors.transparent;

    final lblColor = selected
        ? labelColor ?? Colors.white
        : labelColor ?? context.colors.onSurface;

    final bColor = selected
        ? selectedBorderColor ?? AppColors.primary
        : unSelectedBorderColor ?? context.colors.surfaceContainerLow;

    return Container(
      padding: padding ??  EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius?.r ?? Decorations.borderRadius8.r),
        border: Border.all(color: bColor),
      ),
      child: child ?? Text(
        text,
        style: textStyle ?? TextStyles.bodyMedium.copyWith(color: lblColor),
      ),
    );
  }
}