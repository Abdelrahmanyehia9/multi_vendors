import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/gap.dart';

class AppRadioButton<T> extends StatelessWidget {
  const AppRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.activeColor,
    this.disabled = false,
    this.radius = Decorations.borderRadius24,
    this.size = 14,
    this.child,
    this.gap = 12 ,
    this.labelStyle,

    this.multiSelect = false,
  }) : assert(child != null || label != null);

  final T value;
  final dynamic groupValue;
  final double gap ;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final Color? activeColor;
  final bool disabled;
  final double radius;
  final double size;
  final Widget? child;
  final bool multiSelect;
  final TextStyle? labelStyle ;

  bool get _isSelected {
    if (multiSelect) {
      return (groupValue as List<T>).contains(value);
    }
    return value == groupValue;
  }

  @override
  Widget build(BuildContext context) {
    final color = activeColor ?? AppColors.primary;
    final disabledColor = context.colors.surfaceContainerLow;
    final naturalColor = context.colors.surfaceContainer;
    final boxSize = size * 1.3;
    final effectiveRadius = radius;

    return AppClick(
      onTap: disabled ? null : () => onChanged?.call(value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: boxSize.w,
            height: boxSize.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(effectiveRadius),
              border: Border.all(
                color: disabled
                    ? disabledColor
                    : _isSelected
                    ? color
                    : naturalColor,
                width: 1.1.w,
              ),
              color: _isSelected ? color : Colors.transparent,
            ),
            child: _isSelected
                ? Center(
              child: Icon(MvIcons.checked, color: Colors.white, size: size.sp),
            )
                : null,
          ),
          if (child != null) ...[
            Gap(gap),
            child!,
          ] else if (label != null) ...[
            Gap(gap),
            Text(
              label!,
              style: labelStyle ?? TextStyles.labelSmall.copyWith(
                color: disabled ? disabledColor : null,
                fontSize: size.sp,
              ),
            ),
          ],
        ],
      ),
    );
  }
}