import 'package:multi_vendor/core/enum/notification_templates.dart';
import 'package:multi_vendor/core/enum/notification_type.dart';
import 'package:multi_vendor/core/utils/helper/fake_data.dart';
import 'package:multi_vendor/features/notifications/data/model/notification_payload.dart';

class NotificationModel {
  final int id;
  final Map<String, dynamic> title;
  final Map<String, dynamic> message;
  final NotificationTemplates? template;
  final NotificationPayload? payload;
  final NotificationType type;
  final String? url;
  final bool? isRead;
  final DateTime? createdAt;
  final String? image;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    this.template,
    this.payload,
    this.url,
    this.image,
    this.isRead,
    this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json['id'],
        title: json['title'],
        message: json['message'],
        template: NotificationTemplates.fromString(json['template']),
        payload: json['data']==null?null:NotificationPayload.fromJson(json['data']),
        url: json['url'],
        type: NotificationType.fromString(json['type']),
        isRead: json['is_read'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        image: json['image'],
      );

  factory NotificationModel.fake()=> const  NotificationModel(id: FakeData.fakeInt,
          title: FakeData.fakeMapName,
          message: FakeData.fakeMapDescription,
          type: NotificationType.transactions,
          template: NotificationTemplates.order_shipped) ;
}
