import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/notifications/data/repository/notification_repository.dart';

class NotificationCountCubit extends Cubit<int> {
  final NotificationRepository _repository;
  NotificationCountCubit(this._repository) : super(0);

  Future<void>getCount()async{
   final result =  await _repository.notificationCount() ;
    result.fold(
      (l) => null,
      (r) {
        safeEmit(r);
        _subscribeToNotification();
      },
    );

  }
  Future<void>_subscribeToNotification()async{
    _repository.subscribeToNotification(
      onUpdate: (count) {
        safeEmit(count);
      },
    );
  }
}