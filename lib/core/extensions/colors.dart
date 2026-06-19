import 'package:flutter/material.dart';
extension ColorExtension on Color {
  Color withAppOpacity(double opacity) {
    return withValues(alpha : opacity);
  }
  Color lighten([double amount = .1]) {
    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness(
      (hsl.lightness + amount).clamp(0.0, 1.0),
    );
    return hslLight.toColor();
  }
  Color darken([double amount = .1]) {
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness(
      (hsl.lightness - amount).clamp(0.0, 1.0),
    );
    return hslDark.toColor();
  }



  String  get toRgbString => toARGB32().toString() ;
  static Color? fromRgbString(String value) {
    final int? color = int.tryParse(value);
    return color == null ? null : Color(color);
  }

  Color get veryLight =>lighten().withAppOpacity(0.4) ;
}

