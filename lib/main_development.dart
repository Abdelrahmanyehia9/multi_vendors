import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/di/setup_get_it.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:multi_vendor/core/routes/app_router.dart';
import 'package:multi_vendor/multi_vendor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabaseKey,
    debug: true,
  );
  await Future.wait([
  DI.setupGetIt(),
  AppConstants.setupPhoneSystem(),
    ScreenUtil.ensureScreenSize(),
  ]);
  final AppRouter router = AppRouter();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: userCubit),
        BlocProvider.value(value: cartCubit),
        BlocProvider.value(value: favoriteCubit),
      ],
      child: MultiVendors(router: router),
    ),
  );
}
