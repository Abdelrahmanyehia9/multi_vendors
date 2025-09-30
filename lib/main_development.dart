import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicoo/core/DI/setup_get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/database/shared_pref_helper.dart';
import 'medicoo_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Future.wait([
    setupGetIt(),
    SharedPrefHelper.init(),
    ScreenUtil.ensureScreenSize(),
  ]);
  await Supabase.initialize(
    url: "https://gfzwbdzcgbzfuydoyujo.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdmendiZHpjZ2J6ZnV5ZG95dWpvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTkxNjMzNDQsImV4cCI6MjA3NDczOTM0NH0.xZVAKpnRMTefbN5rO5bYerQRIWAsarnu3rU3f8g0VNc",
  );
  runApp(const MedicooApp());
}



