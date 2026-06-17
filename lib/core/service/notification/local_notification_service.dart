part of 'notification_service.dart';

class _LocalNotificationService {
  _LocalNotificationService._();
  static final _LocalNotificationService _instance = _LocalNotificationService._();
  factory _LocalNotificationService() => _instance;

  static final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  Function(NotificationResponse)? _onClickListener;

  Future<void> init() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _localNotifications.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (response) => _onClickListener?.call(response),
    );
  }

  void setOnClickListener(Function(NotificationResponse) onClicked) {
    _onClickListener = onClicked;
  }

  void showNotification(OSNotification notification) {
    final title = notification.title ?? notification.additionalData?['title'] ?? '';
    final body = notification.body ?? notification.additionalData?['body'] ?? '';
    if (title.isEmpty && body.isEmpty) return;
    final androidDetails = const AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'Used for important push notifications.',
      importance: Importance.max,
      priority: Priority.high,
    );

    final iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    _localNotifications.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title:  title,
      body: body,
      notificationDetails: details,
      payload: json.encode(notification.additionalData ?? {}),
    );
  }}