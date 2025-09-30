import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'medicoo_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://gfzwbdzcgbzfuydoyujo.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdmendiZHpjZ2J6ZnV5ZG95dWpvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTkxNjMzNDQsImV4cCI6MjA3NDczOTM0NH0.xZVAKpnRMTefbN5rO5bYerQRIWAsarnu3rU3f8g0VNc",
  );
  runApp(const MedicooApp());
}