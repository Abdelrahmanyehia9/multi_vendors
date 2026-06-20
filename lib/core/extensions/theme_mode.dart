import 'package:flutter/material.dart' show ThemeMode;

extension ThemeModeExt on ThemeMode{

 static fromString(String? value)  {
   switch (value) {
     case 'light':
       return ThemeMode.light;
     case 'dark':
       return ThemeMode.dark;
     default:
       return ThemeMode.system;
   }
 }
 String toJson()=>name;


}