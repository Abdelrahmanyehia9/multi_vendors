// part of 'notification_service.dart';
//
// class _LocalNotificationService {
//   _LocalNotificationService._();
//   static final _LocalNotificationService _instance = _LocalNotificationService._();
//   factory _LocalNotificationService() => _instance;
//
//   static final FlutterLocalNotificationsPlugin _localNotifications =
//   FlutterLocalNotificationsPlugin();
//
//   Function(NotificationResponse)? _onClickListener;
//
//   Future<void> init() async {
//     const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const iosSettings = DarwinInitializationSettings(
//       requestAlertPermission: false,
//       requestBadgePermission: false,
//       requestSoundPermission: false,
//     );
//     const initSettings = InitializationSettings(
//       android: androidSettings,
//       iOS: iosSettings,
//     );
//     await _localNotifications.initialize(
//       settings: initSettings,
//       onDidReceiveNotificationResponse: (response) => _onClickListener?.call(response),
//     );
//
//     const channel = AndroidNotificationChannel(
//       'high_importance_channel',
//       'High Importance Notifications',
//       description: 'Used for important push notifications.',
//       importance: Importance.high,
//     );
//     await _localNotifications
//         .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//   }
//
//   void setOnClickListener(Function(NotificationResponse) onClicked) {
//     _onClickListener = onClicked;
//   }
//
//   void showNotification(OSNotification notification) {
//     const androidDetails = AndroidNotificationDetails(
//       'high_importance_channel',
//       'High Importance Notifications',
//       channelDescription: 'Used for important push notifications.',
//       importance: Importance.high,
//       priority: Priority.high,
//       icon: '@mipmap/ic_launcher',
//     );
//     const iosDetails = DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );
//     const details = NotificationDetails(android: androidDetails, iOS: iosDetails);
//     _localNotifications.show(
//       id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
//       title: notification.title ?? "",
//       body: notification.body ?? "",
//       notificationDetails: details,
//       payload: json.encode(notification.additionalData),
//     );
//   }
// }