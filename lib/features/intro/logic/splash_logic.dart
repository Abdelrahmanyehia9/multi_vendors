import 'package:flutter/cupertino.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';

class SplashLogic {
  const SplashLogic._();

  static Future<void> init(BuildContext context) async {

    userCubit.init();
  }
}
