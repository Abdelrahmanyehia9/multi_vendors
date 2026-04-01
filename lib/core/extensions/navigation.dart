import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void popUntil({String? routeName, Object? arguments}) {
    if (routeName != null) {
      Navigator.of(this).popUntil((route) => route.settings.name == routeName);
    } else {
      while (Navigator.of(this).canPop()) {
        Navigator.of(this).pop();
      }
    }
  }

  void pop() => Navigator.of(this).pop();
  bool canPop() => Navigator.of(this).canPop();
}