import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';

enum NotificationType {
  activity,  transactions , promotions , others ;
  static NotificationType fromString(String? name) {
    return NotificationType.values.firstWhereOrNull((element) => element.name == name)??others;
  }
  String toJson() => name;
  String get text => name.tr();
}

