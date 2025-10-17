import 'package:flutter/material.dart';
import 'package:medicoo/core/routes/AppRouter.dart';
import 'medicoo_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MedicooApp(router: AppRouter()));
}
