import 'package:flutter/material.dart';

import '../widgets/overlays/snackbars.dart';

extension SizeExt on BuildContext{
   Size get rSize => MediaQuery.sizeOf(this) ;
   double get width => rSize.width  ;
   double get height => rSize.height  ;
}

extension ThemeEXT on BuildContext{
  ThemeData get theme => Theme.of(this) ;
  bool get isDark => theme.brightness == Brightness.dark;
  ColorScheme get colors => theme.colorScheme ;
  Color get scaffoldBackground => theme.scaffoldBackgroundColor;
}



extension SnackBarExt on BuildContext{
 void  showSnackBars ({required String message, String title = ""})  {
 return  SnackBars.custom(message, title: title);
 }
 void successBar({required String message,String title ="all done" })  {
 return  SnackBars.success(message: message, title: title);
 }
 void errorBar({required String message,String title ="error" })  {
 return  SnackBars.error(message: message, title: title);
 }
 void warningBar({required String message,String title ="warning" })  {
 return  SnackBars.warning(message: message, title: title);
 }
}

extension DirectionExt on BuildContext {
  bool get isRTL =>
      Directionality.of(this) == TextDirection.rtl;
}