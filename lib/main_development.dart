import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/di/setup_get_it.dart';
import 'package:multi_vendor/core/service/notification/notification_service.dart';
import 'package:multi_vendor/core/utils/app_assets.dart';
import 'package:multi_vendor/core/utils/app_configs.dart';
import 'package:multi_vendor/core/routes/app_router.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/avera.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide LocalStorage;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    publishableKey: AppConstants.supabaseKey,
    debug: true
  );

  await Future.wait([
    DI.setupGetIt(),
    NotificationService.instance.init(debug: true),
    EasyLocalization.ensureInitialized(),
    AppConfigs.setupPhoneSystem(),
    ScreenUtil.ensureScreenSize(),
  ]);

  final AppRouter router = AppRouter();
  await Future.wait([
    FeatureFlags.init(),
    AppConfigs.init()
  ]) ;
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
      child: Avera(router: router),
    ),
  );
}
