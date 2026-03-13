import 'package:flutter/material.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/features/main/layout.dart';
import '../../features/authentication/view/login_screen.dart';


class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
        case Routes.mainLayout:
        return MaterialPageRoute(
          builder: (_) => const MainLayout(),
        );
      default:
        return null;
    }
  }


}