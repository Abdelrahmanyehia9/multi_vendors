import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/notifications/data/repository/notification_repository.dart';

class NotificationDeleteCubit extends Cubit<BaseState<List<int>>>{
  final NotificationRepository _repository;
  NotificationDeleteCubit(this._repository) : super(const BaseState.initial());
///deleteAll
  Future<void>deleteAllNotification()async{
    safeEmit(const BaseState.loading()) ;
    final result = await _repository.deleteNotification(null);
    result.fold(
          (l) => safeEmit( BaseState.failure(l)),
          (r) => safeEmit( BaseState.success(r)),
    );
  }
  /// delete selected Notifications by IDs
  Future<void>deleteNotifications(List<int>ids)async {
    safeEmit(const BaseState.loading()) ;
    final result = await _repository.deleteNotification(ids);
    result.fold(
      (l) => safeEmit( BaseState.failure(l)),
      (r) => safeEmit( BaseState.success(r)),
    );

  }

}