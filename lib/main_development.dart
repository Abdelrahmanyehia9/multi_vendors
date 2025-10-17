import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicoo/core/DI/setup_get_it.dart';
import 'package:medicoo/core/routes/AppRouter.dart';
import 'core/database/local/shared_pref_helper.dart';
import 'medicoo_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Future.wait([
    setupGetIt(),
    SharedPrefHelper.init(),
    ScreenUtil.ensureScreenSize(),
  ]);
  runApp( MedicooApp(router: AppRouter(),));
}



