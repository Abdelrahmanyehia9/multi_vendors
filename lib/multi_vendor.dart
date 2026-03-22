import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/helper/app_scroll_behavior.dart';
import 'core/routes/app_router.dart';
import 'core/routes/routes.dart';
import 'core/service/navigation_service.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/user_session_builder.dart';

class MultiVendors extends StatelessWidget {
  final AppRouter router;

  const MultiVendors({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        theme: AppTheme.light,
        navigatorKey: NavigationService.navigatorKey,
        scrollBehavior: AppScrollBehavior(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.generateRoute,
        initialRoute: Routes.splash,
        builder: (context, child) => UserSessionBuilder(child: child!),
      ),
    );
  }
}
