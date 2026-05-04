import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:multi_vendor/core/widgets/app_loader_indicator.dart';
import 'package:multi_vendor/shared/view/widgets/user_session_builder.dart';
import 'package:multi_vendor/core/routes/app_router.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/service/navigation_service.dart';
import 'package:multi_vendor/core/theme/app_theme.dart';
import 'package:multi_vendor/core/utils/helper/app_scroll_behavior.dart';

class MultiVendors extends StatelessWidget {
  final AppRouter router;
  const MultiVendors({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GlobalLoaderOverlay(
        overlayColor: Colors.black38,
        overlayWidgetBuilder: (_)=>const AppLoaderIndicator(),
        child: MaterialApp(
          locale: context.locale,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          theme: AppTheme.light,
          navigatorKey: NavigationService.navigatorKey,
          scrollBehavior: AppScrollBehavior(),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: router.generateRoute,
          initialRoute: Routes.splash,
          builder: (context, child) => UserSessionBuilder(child: child!),
        ),
      ),
    );
  }
}
