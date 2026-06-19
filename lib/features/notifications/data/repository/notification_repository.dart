import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/enum/notification_type.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/service/database_service.dart';
import 'package:multi_vendor/core/service/real_time_service.dart';
import 'package:multi_vendor/core/utils/remote_database_constants.dart';
import 'package:multi_vendor/features/notifications/data/model/notification_model.dart';

class NotificationRepository {
  final DatabaseService _db;
  final RealtimeService _realtime;

  NotificationRepository(this._db, this._realtime);

  Future<Either<AppException, List<NotificationModel>>>
  getAllNotifications({NotificationType? type}) async {
    try {
      final result = await _db.GET(
        table: RemoteDatabaseConstants.notification_table,
        filter: (q) {
          var query = q.eq(RemoteDatabaseConstants.is_active_column, true);
          if (type != null) {
            query = query.eq('type', type.name);
          }
          return query.order(
            RemoteDatabaseConstants.created_at_column,
            ascending: false,
          );
        },
      );
      unawaited(_markAllAsRead());
      return right(result.map((e) => NotificationModel.fromJson(e)).toList());
    } catch (e) {
      return left(e.toAppException);
    }
  }
  Future<Either<AppException, int>> notificationCount() async {
    try {
      final result = await _db.COUNT(
        table: RemoteDatabaseConstants.notification_table,
        filter: (q) => q.eq('is_read', false),
      );
      return right(result);
    } catch (e) {
      return left(e.toAppException);
    }
  }
  Future<void> _markAllAsRead() async {
    try {
      await _db.UPDATE_MANY(
        table: RemoteDatabaseConstants.notification_table,
        data: {"is_read": true},
        filter: (q) => q.eq('is_read', false),
      );
    } catch (_) {
      // Best-effort background operation — swallow errors instead of
      // rethrowing into an unawaited future with no listener.
    }
  }
  void subscribeToNotification({
    required void Function(int count) onUpdate,
    void Function(AppException error)? onError,
  }) {
    _realtime.subscribeToTable(
      channelName: RemoteDatabaseConstants.notification_table,
      schema: 'public',
      table: RemoteDatabaseConstants.notification_table,
      callback: (payload) async {
        final result = await notificationCount();
        result.fold(
              (e) => onError?.call(e),
              (count) => onUpdate.call(count),
        );
      },
    );
  }

  Future<Either<AppException, List<int>>> deleteNotification(List<int>?ids)async{
    try{
  final response =  await _db.UPDATE_MANY(table: RemoteDatabaseConstants.notification_table ,
          data: {
            RemoteDatabaseConstants.is_active_column: false
          },
          filter:ids==null? (q)=>q.neq(RemoteDatabaseConstants.is_active_column, false): (q) =>  q.inFilter(RemoteDatabaseConstants.id_column, ids),
      );
  final deletedIds = response
      .map((e) => e['id'])
      .whereType<int>()
      .toList();

  return right(deletedIds);
    }catch(e){
      return left(e.toAppException);
    }
  }
}