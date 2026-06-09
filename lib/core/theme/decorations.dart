import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/colors.dart';

import 'package:multi_vendor/core/widgets/app_text_field.dart';


class Decorations {
  const Decorations._();

  static const double borderRadius4 = 4;
  static const double borderRadius8 = 8;
  static const double borderRadius12 = 12;
  static const double borderRadius16 = 16;
  static const double borderRadius24 = 24;
  static const double borderRadius30 = 30;
  static const double borderRadius50 = 50;


  static final List<BoxShadow> shadow = [
    BoxShadow(
      color: Colors.black.withAppOpacity(0.2),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ] ;
}

class AppInputDecoration {
  final AppBorderType borderType;
  final double borderRadius;
  final Color? borderColor;
  final double borderWidth;

  final EdgeInsets? padding;
  final Color? filledColor;

  /// 🔤 Text
  final String? hintText;
  final String? labelText;
  final String? helperText;

  /// 🎨 Styles
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? helperStyle;
  final TextStyle? errorStyle;

  /// 🔘 Icons
  final Widget? prefix;
  final Widget? suffix;

  /// 🔢 Counter
  final bool hideCounter;

  const AppInputDecoration._({
    this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.borderType,
    this.padding,
    this.filledColor,
    this.hintText,
    this.labelText,
    this.helperText,
    this.hintStyle,
    this.labelStyle,
    this.helperStyle,
    this.errorStyle,
    this.prefix,
    this.suffix,
    this.hideCounter = false,
  });

  /// ✅ default instance
  static const AppInputDecoration instance = AppInputDecoration._(
    borderWidth: 0.5,
    borderRadius: 8,
    borderType: AppBorderType.filled,
  );

  /// 🔁 copyWith
  AppInputDecoration copyWith({
    AppBorderType? borderType,
    double? borderRadius,
    Color? borderColor,
    double? borderWidth,
    EdgeInsets? padding,
    Color? filledColor,
    String? hintText,
    String? labelText,
    String? helperText,
    TextStyle? hintStyle,
    TextStyle? labelStyle,
    TextStyle? helperStyle,
    TextStyle? errorStyle,
    Widget? prefix,
    Widget? suffix,
    bool? hideCounter,

  }) {
    return AppInputDecoration._(
      borderType: borderType ?? this.borderType,
      borderRadius: borderRadius ?? this.borderRadius,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      padding: padding ?? this.padding,
      filledColor: filledColor ?? this.filledColor,
      hintText: hintText ?? this.hintText,
      labelText: labelText ?? this.labelText,
      helperText: helperText ?? this.helperText,
      hintStyle: hintStyle ?? this.hintStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      helperStyle: helperStyle ?? this.helperStyle,
      errorStyle: errorStyle ?? this.errorStyle,
      prefix: prefix ?? this.prefix,
      suffix: suffix ?? this.suffix,
      hideCounter: hideCounter ?? this.hideCounter,
    );
  }

  InputBorder getBorder(BuildContext context) {
    final theme = Theme.of(context);

    switch (borderType) {
      case AppBorderType.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        );

      case AppBorderType.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor ?? theme.colorScheme.surfaceContainerLow,
            width: borderWidth,
          ),
        );

      case AppBorderType.underlined:
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? theme.colorScheme.surfaceContainerLow,
            width: borderWidth,
          ),
        );

      case AppBorderType.none:
        return InputBorder.none;
    }
  }
  InputBorder getFocusedBorder(BuildContext context) {
    final theme = Theme.of(context);

    switch (borderType) {
      case AppBorderType.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        );

      case AppBorderType.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor ?? theme.colorScheme.primary,
            width: borderWidth,
          ),
        );

      case AppBorderType.underlined:
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? theme.colorScheme.primary,
            width: borderWidth,
          ),
        );

      case AppBorderType.none:
        return InputBorder.none;
    }
  }
  InputBorder getErrorBorder() {
    switch (borderType) {
      case AppBorderType.filled:
      case AppBorderType.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: Colors.red,
            width: borderWidth,
          ),
        );

      case AppBorderType.underlined:
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: borderWidth,
          ),
        );

      case AppBorderType.none:
        return InputBorder.none;
    }
  }
  InputDecoration inputDecoration(BuildContext context) {
    final theme = Theme.of(context);

    return InputDecoration(
      contentPadding: padding,
      prefixIcon: prefix,
      suffixIcon: suffix,
      prefixIconColor: theme.colorScheme.surfaceContainer,
      suffixIconColor: theme.colorScheme.surfaceContainer,
      hintText: hintText,
      labelText: labelText,
      helperText: helperText,
      hintStyle:
      hintStyle ?? TextStyle(color: theme.colorScheme.surfaceContainer),
      labelStyle:
      labelStyle ?? TextStyle(color: theme.colorScheme.surfaceContainer),
      helperStyle: helperStyle,
      errorStyle: errorStyle,
      filled: borderType == AppBorderType.filled,
      fillColor: filledColor ??
          (borderType == AppBorderType.filled
              ? theme.colorScheme.surfaceContainerLowest
              : null),

      counterText: hideCounter ? '' : null,
      border: getBorder(context),
      enabledBorder: getBorder(context),
      disabledBorder: getBorder(context),
      focusedBorder: getFocusedBorder(context),
      errorBorder: getErrorBorder(),
      focusedErrorBorder: getErrorBorder(),
    );
  }
}

