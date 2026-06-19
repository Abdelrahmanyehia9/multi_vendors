import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/enum/notification_type.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/notifications/data/model/notification_model.dart';
import 'package:multi_vendor/features/notifications/data/repository/notification_repository.dart';

class NotificationCubit extends Cubit<BaseState<List<NotificationModel>>>{
  final NotificationRepository _repository;
  NotificationCubit(this._repository) : super(const BaseState.initial());
  Future<void> getAllNotifications({NotificationType? type}) async {
    safeEmit(const BaseState.loading());
    final result = await _repository.getAllNotifications(type: type);
    result.fold(
          (l) => safeEmit(BaseState.failure(l)),
          (r) {
        if (r.isEmpty) return safeEmit(const BaseState.empty());
        safeEmit(BaseState.success(r));
      },
    );
  }
 void deleteNotifications(List<int>ids){
    final newData = state.data?.where((element) => !ids.contains(element.id)).toList() ;
    if(newData?.isEmpty==true) return safeEmit(const BaseState.empty());
    safeEmit(
        state.copyWith(
      data: newData,
    ));
  }
}