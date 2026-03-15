import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import '../theme/app_colors.dart';
import '../theme/text_styles.dart';

class AppChip extends StatelessWidget {
  final String text;
  final bool selected;
  final Color? borderColor;
  final Color? backgroundColor;
  final EdgeInsets? padding ;
  final Color? labelColor;
  final Widget? child;
  final double? elevation;

  const AppChip({
    super.key,
    required this.text,
    this.elevation,
    this.selected = false,
    this.borderColor,
    this.backgroundColor,
    this.labelColor,
    this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = selected
        ? backgroundColor ?? AppColors.primary
        : backgroundColor ?? Colors.transparent;

    final lblColor = selected
        ? labelColor ?? Colors.white
        : labelColor ?? context.colors.onSurface;

    final bColor = borderColor ??
        (selected ? AppColors.primary : context.colors.surfaceContainerLow);

    return Chip(
      padding: padding,
      elevation: elevation,
      label: child ??  Text(
        text,
        style: TextStyles.bodySmall.copyWith(color: lblColor),
      ),
      backgroundColor: bgColor,
      side: BorderSide(color: bColor),
    );
  }
}