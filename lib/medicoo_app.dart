import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicoo/core/routes/AppRouter.dart';
import 'package:medicoo/core/routes/routes.dart';
import 'package:medicoo/core/theme/app_theme.dart';
import 'features/authentication/view/login_screen.dart';

class MedicooApp extends StatelessWidget {
  final AppRouter router ; 
  const MedicooApp({super.key , required this.router});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
          designSize: const Size(430, 932),
          minTextAdapt: true,
          splitScreenMode: true,
      child: MaterialApp(
        theme: AppTheme.light,
        onGenerateRoute: router.generateRoute,
        initialRoute: Routes.loginScreen,
        home: LoginScreen(),
      ),
    );
  }
}
