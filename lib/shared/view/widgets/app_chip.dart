import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';

class AppChip extends StatelessWidget {
  final String text;
  final bool selected;
  final Color? unSelectedBorderColor;
  final Color? selectedBorderColor;
  final Color? selectedColor;
  final EdgeInsets? padding ;
  final Color? labelColor;
  final Widget? child;
  final double? elevation;
  final  Color? unselectedColor;
  final TextStyle? textStyle;

  const AppChip({
    super.key,
    required this.text,
    this.elevation,
    this.selected = false,
    this.unselectedColor,
    this.unSelectedBorderColor,
    this.selectedColor,
    this.labelColor,
    this.child,
    this.padding,
    this.textStyle,
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
    return Chip(
      padding: padding,
      elevation: elevation,
      label: child ??  Text(
        text,
        style: textStyle ?? TextStyles.bodySmall.copyWith(color: lblColor),
      ),
      backgroundColor: bgColor,
      side: BorderSide(color: bColor),
    );
  }
}