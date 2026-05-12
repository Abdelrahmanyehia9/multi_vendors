// part of 'notification_service.dart';
//
// class PushNotificationService {
//   PushNotificationService._();
//   static final PushNotificationService _instance = PushNotificationService._();
//
//   factory PushNotificationService() => _instance;
//
//   bool _initialized = false;
//
//   Future<void> _initialize(String appId, {bool debug = false}) async {
//     if (_initialized) return;
//     OneSignal.initialize(appId);
//     if (debug) {
//       OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
//     }
//     await OneSignal.Notifications.requestPermission(true);
//     _initialized = true;
//   }
//
//   void setupListeners({
//     required Function(OSNotificationWillDisplayEvent) onForegroundMessage,
//     required Function(OSNotification) onReceivedRemoteMessage,
//     void Function(OSPushSubscriptionChangedState)? stateObserver,
//   }) {
//     OneSignal.Notifications.addForegroundWillDisplayListener(onForegroundMessage);
//     OneSignal.Notifications.addClickListener((event) => onReceivedRemoteMessage(event.notification));
//     OneSignal.User.pushSubscription.addObserver((state) => stateObserver?.call(state));
//   }
//
//   Future<bool> hasPermission() async => OneSignal.Notifications.permission;
//   Future<bool> requestPermission() async => await OneSignal.Notifications.requestPermission(true);
//   String? get playerId => OneSignal.User.pushSubscription.id;
//   String? get pushToken => OneSignal.User.pushSubscription.token;
//   void setExternalUserId(String userId) => OneSignal.login(userId);
//   void removeExternalUserId() => OneSignal.logout();
//   void sendTags(Map<String, dynamic> tags) => OneSignal.User.addTags(tags);
//   void removeTag(String key) => OneSignal.User.removeTag(key);
//   void removeTags(List<String> keys) => OneSignal.User.removeTags(keys);
//   void optIn() => OneSignal.User.pushSubscription.optIn();
//   void optOut() => OneSignal.User.pushSubscription.optOut();
//   bool get isSubscribed => OneSignal.User.pushSubscription.optedIn ?? false;
// }