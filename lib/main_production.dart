import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/di/setup_get_it.dart';
import 'package:multi_vendor/core/utils/app_assets.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/core/routes/app_router.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/multi_vendor.dart';
import 'package:multi_vendor/shared/view/error_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabaseKey,
    debug: false,
  );

  await Future.wait([
    DI.setupGetIt(),
    EasyLocalization.ensureInitialized(),
    AppConstants.setupPhoneSystem(),
    ScreenUtil.ensureScreenSize(),
  ]);

  final AppRouter router = AppRouter();
  await FeatureFlags.init();
  ErrorWidget.builder = (_) {
    return const ErrorScreen() ;
  };
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale("fr"),
        Locale("es"),
        Locale("zh"),
      ],
      path: AppAssets.languagesPack,
      fallbackLocale: const Locale('en'),
      child: MultiVendors(router: router),
    ),
  );
}
