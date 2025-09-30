import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicoo/core/theme/app_theme.dart';
import 'features/authentication/view/login_screen.dart';

class MedicooApp extends StatelessWidget {
  const MedicooApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
          designSize: const Size(430, 932),
          minTextAdapt: true,
          splitScreenMode: true,
      child: MaterialApp(
        theme: AppTheme.light,
        home: LoginScreen(),
      ),
    );
  }
}
