import 'package:flutter/material.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';

class AppTheme {
  const AppTheme._();

  static final Color _lightBackgroundColor = const Color(0xfffcfcfd);
  static final Color _darkBackgroundColor = const Color.fromRGBO(
      14, 14, 20, 1.0);
  static final TooltipThemeData _tooltipThemeData = const TooltipThemeData(
    verticalOffset: 2,
    margin: EdgeInsets.zero,
    textStyle: TextStyle(color: Colors.white),
    decoration: BoxDecoration(color: AppColors.primary),
  );

  static final AppBarTheme _appBarTheme = const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
    leadingWidth: 60,
    toolbarHeight: 60,
    actionsPadding: EdgeInsets.symmetric(horizontal: 4),
  );

  static String _fontFamily(Locale locale) {
    return switch (locale.languageCode) {
      'ar' => TextStyles.arFontFamily,
      _ => TextStyles.enFontFamily,
    };
  }

  static ThemeData light(Locale locale) => ThemeData(
    scaffoldBackgroundColor: _lightBackgroundColor,
    canvasColor: _lightBackgroundColor,

    datePickerTheme: DatePickerThemeData(
      backgroundColor: _lightBackgroundColor,
      headerForegroundColor: Colors.white,
      headerBackgroundColor: AppColors.primary,
    ),
    colorScheme: _ColorScheme.light,
    fontFamily: _fontFamily(locale),
    appBarTheme: _appBarTheme,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    tooltipTheme: _tooltipThemeData,
    dividerColor: Colors.transparent,
    dividerTheme: const DividerThemeData(
      color: AppColors.grey200,
      thickness: 1.5,
    ),
    useMaterial3: true,
  );

  static ThemeData dark(Locale locale) => ThemeData(
    scaffoldBackgroundColor: _darkBackgroundColor,
    canvasColor: _darkBackgroundColor,
    colorScheme: _ColorScheme.dark,
    datePickerTheme: DatePickerThemeData(
      backgroundColor: _darkBackgroundColor,
      headerForegroundColor: Colors.white,
      headerBackgroundColor: AppColors.primary,
    ),
    splashColor: Colors.transparent,
    appBarTheme: _appBarTheme,
    fontFamily: _fontFamily(locale),
    highlightColor: Colors.transparent,
    tooltipTheme: _tooltipThemeData,
    dividerColor: Colors.transparent,
    dividerTheme: const DividerThemeData(
      color: AppColors.grey700,
      space: 24,
      thickness: 2,
    ),
    useMaterial3: true,
  );
}

class _ColorScheme {
  const _ColorScheme._();

  static ColorScheme light = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    primary: AppColors.primary,
    onPrimary: Colors.white,
    secondary: AppColors.secondary,
    onSecondary: Colors.white,
    onTertiary: Colors.white,
    error: AppColors.error,
    onError: Colors.white,
    surface: AppColors.white,
    surfaceContainerLowest: AppColors.grey200,
    surfaceContainerLow: AppColors.grey300,
    surfaceContainer: AppColors.grey500,
    surfaceContainerHigh: AppColors.grey700,
    surfaceContainerHighest: AppColors.grey900,
  );

  static ColorScheme dark = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    primary: AppColors.primary,
    onPrimary: Colors.white,
    surface: Colors.black,
    secondary: AppColors.secondary,
    onSecondary: Colors.white,
    onTertiary: Colors.white,
    error: AppColors.error,
    onError: Colors.white,
    brightness: Brightness.dark,
    surfaceContainerLowest: AppColors.grey800,
    surfaceContainerLow: AppColors.grey700,
    surfaceContainer: AppColors.grey600,
    surfaceContainerHigh: AppColors.grey400,
    surfaceContainerHighest: AppColors.grey200,
  );
}