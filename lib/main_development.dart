import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/DI/setup_get_it.dart';
import 'core/database/shared_pref_helper.dart';
import 'core/routes/app_router.dart';
import 'multi_vendor.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Future.wait([
    setupGetIt(),
    SharedPrefHelper.init(),
    ScreenUtil.ensureScreenSize(),
  ]);
  final AppRouter router =AppRouter() ;
  runApp( MultiVendors(router: router,));
}



