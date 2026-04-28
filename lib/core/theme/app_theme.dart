import 'package:flutter/material.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';

class AppTheme {
  const AppTheme._();
  static final Color _lightBackgroundColor = const Color(0xffFCFCFC);
  static final Color _darkBackgroundColor = const Color.fromRGBO(11, 15, 20, 1);
  static final TooltipThemeData _tooltipThemeData = const TooltipThemeData(
    verticalOffset: 2,
    margin: EdgeInsets.zero,
    decoration: BoxDecoration(color: AppColors.secondary),
  );
 static final AppBarTheme _appBarTheme = const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0 ,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
    leadingWidth: 60,
    toolbarHeight: 60,

    actionsPadding: EdgeInsets.symmetric(horizontal: 4),
  ) ;
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: _lightBackgroundColor,
    canvasColor: _lightBackgroundColor,
    datePickerTheme: DatePickerThemeData(
        backgroundColor: _lightBackgroundColor,
        headerForegroundColor: Colors.white,
        headerBackgroundColor: AppColors.primary
    ),
    colorScheme: _ColorScheme.light,
    fontFamily: TextStyles.fontFamily,
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
  static ThemeData dark = ThemeData(
    scaffoldBackgroundColor: _darkBackgroundColor,
    canvasColor: _darkBackgroundColor,
    colorScheme: _ColorScheme.dark,
    datePickerTheme: DatePickerThemeData(
        backgroundColor: _darkBackgroundColor,
        headerForegroundColor: Colors.white,
        headerBackgroundColor: AppColors.primary
    ),
    splashColor: Colors.transparent,
    appBarTheme: _appBarTheme,
    fontFamily: TextStyles.fontFamily,
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
    secondary: AppColors.secondary,
    onSecondary: Colors.white,
    onTertiary: Colors.white,
    error: AppColors.error,
    onError: Colors.white,
    brightness: Brightness.dark,
    surfaceContainerLowest: AppColors.grey900,
    surfaceContainerLow: AppColors.grey800,
    surfaceContainer: AppColors.grey500,
    surfaceContainerHigh: AppColors.grey100,
    surfaceContainerHighest: AppColors.grey50,
  );
}