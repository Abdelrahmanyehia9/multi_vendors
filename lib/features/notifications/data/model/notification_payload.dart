class NotificationPayload {
  final String? redirect ;
  final int? id ;
  NotificationPayload({this.redirect , this.id ,});
  factory NotificationPayload.fromJson(Map<String, dynamic> json) =>
      NotificationPayload(
        redirect: json['screen'],
        id: json['id'],
      );
}