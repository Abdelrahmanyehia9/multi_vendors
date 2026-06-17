import 'package:flutter/material.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/overlays/snackbars.dart';

extension SizeExt on BuildContext {
  Size get rSize => MediaQuery.sizeOf(this);
  double get width => rSize.width;
  double get height => rSize.height;
  double get topSafeArea => MediaQuery.of(this).padding.top;
  double get bottomSafeArea => MediaQuery.of(this).padding.bottom;
}

extension ThemeEXT on BuildContext {
  ThemeData get theme => Theme.of(this);
  bool get isDark => theme.brightness == Brightness.dark;
  ColorScheme get colors => theme.colorScheme;
  Color get scaffoldBackground => theme.scaffoldBackgroundColor;
}

extension SnackBarExt on BuildContext {
  void showSnackBars({required String message, String title = ""}) {
    return SnackBars.custom(context: this, message, title: title);
  }

  void successBar({
    required String message,
    String title = AppStrings.operationDidSuccessfully,
  }) {
    return SnackBars.success(context: this, message: message, title: title);
  }

  void errorBar({
    required String message,
    String title = AppStrings.errorOccurred,
  }) {
    return SnackBars.error(context: this, message: message, title: title);
  }

  void warningBar({
    required String message,
    String title = AppStrings.warning,
  }) {
    return SnackBars.warning(context: this, message: message, title: title);
  }

  void flash({required String message, Color? color, Color? textColor}) {
    SnackBars.custom(
      message,
      context: this,
      duration: const Duration(seconds: 1),
      showGradient: false,
      radius: 12,
      behavior: SnackBarBehavior.floating,
      backgroundColor: color ?? colors.surfaceContainerHighest,
      titleStyle: TextStyles.bodyMedium.copyWith(
        color: textColor ?? scaffoldBackground,
      ),
    );
  }
}

extension DirectionExt on BuildContext {
  bool get isRTL => Directionality.of(this) == TextDirection.rtl;
}
