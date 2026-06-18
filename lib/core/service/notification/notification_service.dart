// notification_service.dart
library;

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
part 'push_notification_service.dart';
part 'local_notification_service.dart';

class NotificationService {
  final _LocalNotificationService _localNotificationService;
  final PushNotificationService _pushNotificationService;
  const NotificationService._(
      this._localNotificationService,
      this._pushNotificationService,
      );
  static final  NotificationService _fullInstance = NotificationService._(_LocalNotificationService._instance, PushNotificationService._instance);
  static NotificationService get instance => _fullInstance;
  static bool _debug = false;
  Future<void> init({bool debug = false}) async {
    _debug = debug;
    await _localNotificationService.init();
    await _pushNotificationService._initialize(AppConstants.onesignalAppId, debug: _debug);
    _log("Notification Service initialized");
  }
  void login(String? uID) =>_pushNotificationService.setExternalUserId(uID);
  void logout() => _pushNotificationService.removeExternalUserId() ;

  Future<void> setupListeners({
    Function(OSNotificationWillDisplayEvent)? onForegroundMessage,
    required Function(OSNotification) onReceivedRemoteMessage,
    void Function(OSPushSubscriptionChangedState)? stateObserver,
    Function(NotificationResponse)? onLocalNotificationClicked,
  }) async {
    /// locale notification listeners
    _localNotificationService.setOnClickListener((notification) {
      _log("Notification clicked ${notification.data}", isLocalNotification: true);
      onLocalNotificationClicked?.call(notification);
    });
 /// push notification listeners
    _pushNotificationService.setupListeners(
      onForegroundMessage: (event) {
         event.preventDefault() ;
        _localNotificationService.showNotification(event.notification);
        _log("Notification received in foreground ${event.notification.title}", isLocalNotification: true);
        onForegroundMessage?.call(event);
      },
      onReceivedRemoteMessage: (clicked) {
        onReceivedRemoteMessage.call(clicked);
      },
      stateObserver: stateObserver,
    );
  }
  PushNotificationService get oneSignal => _pushNotificationService;
  void _log(String message, {bool? isLocalNotification}) {
    if (_debug && kDebugMode) {
      debugPrint(
        "🔔 ${isLocalNotification == null ? "" : isLocalNotification ? "[Local Notification]" : "[Push Notification]"} $message",
      );
    }
  }
}