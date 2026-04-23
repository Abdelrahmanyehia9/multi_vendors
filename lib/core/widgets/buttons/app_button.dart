import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';
import '../app_click.dart';

enum ButtonSize {
  small,
  medium,
  large;

  Size get size => switch (this) {
    ButtonSize.small => Size(100.w, 44.h),
    ButtonSize.medium => Size(200.w, 50.h),
    ButtonSize.large => Size(double.infinity, 60.h),
  };
}

enum ButtonVariant { filled, outlined, text }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final TextStyle? style;
  final Size? fixedSize;
  final bool enableGradient;
  final double? borderWidth;
  final double borderRadius;
  final String? toolTip;

  final EdgeInsetsGeometry? padding;
  final Gradient? gradient;
  final Widget? icon;
  final ButtonSize? buttonSize;
  final ButtonVariant variant;
  final bool enabled;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.color,
    this.textColor,
    this.borderColor,
    this.style,
    this.fixedSize,
    this.borderWidth,
    this.borderRadius = 8,
    this.padding,
    this.gradient,
    this.icon,
    this.toolTip,
    this.buttonSize = ButtonSize.medium,
    this.enableGradient = false,
    this.variant = ButtonVariant.filled,
    this.enabled = true,
    this.isLoading = false,
  });

  factory AppButton.filled({
    required String text,
    VoidCallback? onPressed,
    Color? color,
    Color? textColor,
    Color? borderColor,
    Gradient? gradient,
    TextStyle? style,
    Size? fixedSize,
    String? toolTip,
    double? borderRadius,
    double? borderWidth,
    Widget? icon,
    ButtonSize? buttonSize,
    bool enabled = true,
    bool enableGradient = true,
  }) => AppButton(
    text: text,
    onPressed: onPressed,
    color: color ?? AppColors.primary,
    textColor: textColor,
    borderColor: borderColor,
    gradient: gradient,
    style: style,
    fixedSize: fixedSize,
    toolTip: toolTip,
    enableGradient: enableGradient,
    borderRadius: borderRadius ?? 7,
    borderWidth: borderWidth,
    icon: icon,
    buttonSize: buttonSize,
    enabled: enabled,
  );

  factory AppButton.outlined({
    required String text,
    VoidCallback? onPressed,
    Color? color,
    Color? textColor,
    Gradient? gradient,
    TextStyle? style,
    Size? fixedSize,
    double? borderRadius,
    double? borderWidth,
    Widget? icon,
    String? toolTip,
    ButtonSize? buttonSize,
    bool enabled = true,
  }) => AppButton(
    text: text,
    onPressed: onPressed,
    color: Colors.transparent,
    textColor: textColor ?? color ?? AppColors.primary,
    borderColor: color ?? AppColors.primary,
    gradient: gradient,
    style: style,
    fixedSize: fixedSize,
    toolTip: toolTip,
    borderRadius: borderRadius ?? 7,
    borderWidth: borderWidth,
    icon: icon,
    buttonSize: buttonSize,
    enabled: enabled,
    variant: ButtonVariant.outlined,
  );

  factory AppButton.text({
    required String text,
    VoidCallback? onPressed,
    Color? color,
    TextStyle? style,
    EdgeInsets? padding,
    String? toolTip,
    Size? fixedSize,
  }) => AppButton(
    text: text,
    onPressed: onPressed,
    color: color ?? AppColors.primary,
    style: style,
    fixedSize: fixedSize,
    toolTip: toolTip,
    buttonSize: null,
    padding: padding ?? EdgeInsets.zero,
    variant: ButtonVariant.text,
  );

  factory AppButton.loading({
    Color? color,
    Color? textColor,
    Color? borderColor,
    Size? fixedSize,
    double borderRadius = 8,
  }) => AppButton(
    text: '',
    enabled: false,
    isLoading: true,
    color: color ?? AppColors.primary,
    textColor: textColor,
    borderColor: borderColor,
    fixedSize: fixedSize ?? Size(double.infinity, 50.h),
    borderRadius: borderRadius,
  );

  factory AppButton.icon({
    required Widget icon,
    VoidCallback? onPressed,
    Color color = AppColors.primary,
    Color? borderColor,
    double? borderWidth,
    double borderRadius = 8,
    Size? fixedSize,
    String? toolTip,
    bool enabled = true,
    bool isLoading = false,
    EdgeInsets? padding,
    ButtonVariant variant = ButtonVariant.filled,
  }) => AppButton(
    text: '',
    onPressed: onPressed,
    color: color,
    borderColor: borderColor ?? color,
    borderWidth: borderWidth,
    borderRadius: borderRadius,
    fixedSize: fixedSize,
    variant: variant,
    toolTip: toolTip,
    icon: icon,
    padding: padding ?? EdgeInsets.all(4.w),
    enabled: enabled,
    buttonSize: null,
    isLoading: isLoading,
  );

  bool get _isTransparentVariant =>
      variant == ButtonVariant.text || variant == ButtonVariant.outlined;

  Size? get _resolvedSize {
    if (buttonSize != null) return buttonSize!.size;
    return fixedSize;
  }

  Color _resolveButtonColor(BuildContext context) {
    if (!enabled) return context.colors.surfaceContainerLow;
    if (_isTransparentVariant) return Colors.transparent;
    return color ?? AppColors.primary;
  }

  Color _resolveTextColor(BuildContext context) {
    if (!enabled) return context.colors.surfaceContainerHigh;
    if (textColor != null) return textColor!;
    if (_isTransparentVariant) return color ?? AppColors.primary;
    return Colors.white;
  }

  Gradient? _resolveGradient(BuildContext context) {
    if (!enableGradient || _isTransparentVariant || !enabled) return null;
    final base = _resolveButtonColor(context);
    return gradient ??
        LinearGradient(colors: [base.darken(0.2), base.darken(0.14), base]);
  }

  @override
  Widget build(BuildContext context) {
    final size = _resolvedSize;
    final resolvedBorderColor = borderColor ?? Colors.transparent;
    final resolvedGradient = _resolveGradient(context);

    if (isLoading) {
      return Container(
        width: size?.width,
        height: size?.height ?? 40.h,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: color ?? AppColors.primary,
          border: Border.all(color: resolvedBorderColor),
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        child: Center(
          child: SpinKitThreeBounce(
            color: textColor ?? Colors.white,
            size: style?.fontSize ?? TextStyles.bodyMedium.fontSize ?? 20.w,
          ),
        ),
      );
    }
    final String? message = toolTip ?? (text.isNotEmpty ? text : null);
    return AppClick(
      onTap: enabled ? onPressed : null,
      toolTip: message,
      child: Container(
        width: size?.width,
        height: size?.height ?? 40.h,
        alignment: Alignment.center,
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          gradient: resolvedGradient,
          color: resolvedGradient == null ? _resolveButtonColor(context) : null,
          border: Border.all(
            color: resolvedBorderColor,
            width: borderWidth ?? 1,
          ),
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Theme(
                data: ThemeData(
                  iconTheme: IconThemeData(color: _resolveTextColor(context)),
                ),
                child: text.isNotEmpty ? icon!.paddingHr(8) : icon!,
              ),
            if (text.isNotEmpty)
              Text(
                text,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: (style ?? TextStyles.bodyMedium).copyWith(
                  color: _resolveTextColor(context),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

