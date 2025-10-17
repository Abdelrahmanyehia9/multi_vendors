import 'package:flutter/material.dart';
import 'package:medicoo/core/routes/routes.dart';
import '../../features/authentication/view/login_screen.dart';


class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      default:
        return null;
    }
  }


}