import 'package:flutter/material.dart';

extension SizeExt on BuildContext{
   Size get rSize => MediaQuery.sizeOf(this) ;
   double get width => rSize.width  ;
   double get height => rSize.height  ;
}

extension ThemeEXT on BuildContext{
  ThemeData get theme => Theme.of(this) ;
  ColorScheme get colors => theme.colorScheme ;
  Color get scaffoldBackground => theme.scaffoldBackgroundColor;
}

