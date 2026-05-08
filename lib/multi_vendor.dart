import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:multi_vendor/core/di/setup_get_it.dart';
import 'package:multi_vendor/core/widgets/app_loader_indicator.dart';
import 'package:multi_vendor/shared/view/widgets/user_prefrences_builder.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: userCubit),
        BlocProvider.value(value: cartCubit..init()),
        BlocProvider.value(value: favoriteCubit..init()),
        BlocProvider.value(value: userPreferencesCubit..init()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: GlobalLoaderOverlay(
          overlayColor: Colors.black38,
          overlayWidgetBuilder: (_)=>const AppLoaderIndicator(),
          child: UserPreferencesBuilder(
            builder:(mode, locale)=> MaterialApp(
              locale: locale,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              theme: AppTheme.light(locale),
              darkTheme: AppTheme.dark(locale),
              themeMode: mode,
              navigatorKey: NavigationService.navigatorKey,
              scrollBehavior: AppScrollBehavior(),
              debugShowCheckedModeBanner: false,
              onGenerateRoute: router.generateRoute,
              initialRoute: Routes.splash,
              builder: (context, child) => UserSessionBuilder(child: child!),
            ),
          ),
        ),
      ),
    );
  }
}
