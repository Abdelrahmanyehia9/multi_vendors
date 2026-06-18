import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:multi_vendor/core/di/setup_get_it.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/service/deep_link.dart';
import 'package:multi_vendor/core/service/navigation_service.dart';
import 'package:multi_vendor/core/service/notification/notification_service.dart';
import 'package:multi_vendor/core/utils/app_configs.dart';
import 'package:multi_vendor/features/notifications/data/model/notification_payload.dart';
import 'package:multi_vendor/features/notifications/logic/helper/notification_redirect_helper.dart';
import 'package:multi_vendor/shared/view/result_screen.dart';
import 'package:multi_vendor/shared/view/widgets/message_alert.dart';

class SplashLogic {
  const SplashLogic._();

  static Future<void> init(BuildContext context) async {
    if ((AppConfigs.packageInfo?.buildNumber ?? '0').compareTo(
          AppConfigs.requiredBuild,
        ) ==
        -1) {
      NavigationService.context?.pushNamedAndRemoveUntil(
        Routes.result,
        arguments:  const ResultScreenArgs(
          type: MessagesAlertType.versionNotSupported,
          // action: (context)=> AppButton(text: upda)
        ),
        predicate: (_) => false,
      );
    } else if (AppConfigs.isMaintenance) {
      NavigationService.context?.pushNamedAndRemoveUntil(
        Routes.result,
        arguments: const ResultScreenArgs(type: MessagesAlertType.maintenance),
        predicate: (_) => false,
      );
    } else {
      userCubit.init();
      NotificationService.instance.setupListeners(onReceivedRemoteMessage: (_){}, onLocalNotificationClicked: (noti){
        if(noti.payload==null) return;
        final NotificationPayload payload = NotificationPayload.fromJson(jsonDecode(noti.payload!)) ;
        NotificationRedirectHelper.instance.redirect(payload);
      }) ;
      if(context.mounted)userPreferencesCubit.init(context);
      DeepLinkService.instance.initDeepLink();
    }
  }
}
