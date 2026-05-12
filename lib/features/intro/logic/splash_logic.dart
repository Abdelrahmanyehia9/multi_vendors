import 'package:flutter/widgets.dart';
import 'package:multi_vendor/core/di/setup_get_it.dart';
import 'package:multi_vendor/core/service/deep_link.dart';

class SplashLogic {
  const SplashLogic._();

  static Future<void> init(BuildContext context) async {
     userCubit.init();
     userPreferencesCubit.init(context);
    DeepLinkService.instance.initDeepLink();
  }
}
