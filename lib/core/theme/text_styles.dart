import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles {
  static const String enFontFamily = "Montserrat";
  static const String arFontFamily = "Tajawal";
  static const double _largerFactor = 1.1;
  const TextStyles._();
  static final TextStyle headline1 = TextStyle(
    fontSize: 40.sp * _largerFactor,
    fontWeight: FontWeightHelper.black,
  );
  static final TextStyle headline2 = TextStyle(
    fontSize: 34.sp * _largerFactor,
    fontWeight: FontWeightHelper.bold,
  );
  static final TextStyle headline3 = TextStyle(
    fontSize: 22.sp * _largerFactor,
    fontWeight: FontWeightHelper.bold,
  );
  static final TextStyle bodyLarge = TextStyle(
    fontSize: 18.sp * _largerFactor,
    fontWeight: FontWeightHelper.regular,
  );
  static final TextStyle bodyMedium = TextStyle(
    fontSize: 15.sp * _largerFactor,
    fontWeight: FontWeightHelper.regular,
  );
  static final TextStyle bodySmall = TextStyle(
    fontSize: 13.sp * _largerFactor,
    fontWeight: FontWeightHelper.regular,
  );
  static final TextStyle labelLarge = TextStyle(
    fontSize: 18.sp * _largerFactor,
    fontWeight: FontWeightHelper.medium,
  );
  static final TextStyle labelMedium = TextStyle(
    fontSize: 15.sp * _largerFactor,
    fontWeight: FontWeightHelper.medium,
  );
  static final TextStyle labelSmall = TextStyle(
    fontSize: 13.sp * _largerFactor,
    fontWeight: FontWeightHelper.medium,
  );
  static final TextStyle captionLarge = TextStyle(
    fontSize: 16.sp * _largerFactor,
    fontWeight: FontWeightHelper.light,
  );
  static final TextStyle captionMedium = TextStyle(
    fontSize: 14.sp * _largerFactor,
    fontWeight: FontWeightHelper.light,
  );
  static final TextStyle captionSmall = TextStyle(
    fontSize: 12.sp * _largerFactor,
    fontWeight: FontWeightHelper.light,
  );
}

class FontWeightHelper {
  const FontWeightHelper._();

  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}
