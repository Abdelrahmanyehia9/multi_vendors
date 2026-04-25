import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/enum/order_status.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/queries/shop_queries.dart';
import 'package:multi_vendor/core/service/real_time_service.dart';
import 'package:multi_vendor/core/utils/remote_database_constants.dart';
import 'package:multi_vendor/features/shop/history/data/model/order_tracking_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/service/database_service.dart';
import '../../../shared/model/order_model.dart';

class OrderHistoryRepository {
  final DatabaseService _db;
  final RealtimeService _realtime;

  OrderHistoryRepository(this._db, this._realtime);

  /// real time channels
  final Set<String>_channels = {};

  Future<Either<AppException, List<OrderModel>>> getOrdersHistory() async {
    try {
      final response = await _db.GET(
        table: RemoteDatabaseConstants.orders_table,
        select: ShopQueries.orderHistory,
        filter: (e)=>e.eq(RemoteDatabaseConstants.is_active_column, true).order(RemoteDatabaseConstants.created_at_column, ascending: false)
      );
      final orders = (response as List)
          .map((e) => OrderModel.fromJson(e))
          .toList();
      return right(orders);
    } catch (e) {
      return left(e.toAppException);
    }
  }

  Future<Either<AppException, OrderModel>> getOrderDetails(int orderId) async {
    try {
      final response = await _db.GET_SINGLE(
        filter: (e) => e.eq(RemoteDatabaseConstants.id_column, orderId),
        table: RemoteDatabaseConstants.orders_table,
        select: ShopQueries.orderDetails,
      );
      final order = OrderModel.fromJson(response);
      return right(order);
    } catch (e) {
      return left(e.toAppException);
    }
  }

  Future<Either<AppException, OrderTrackingModel>> getOrderTrackingDetails(
      int trackId) async {
    final response = await _db.GET_SINGLE(
      filter: (e) => e.eq(RemoteDatabaseConstants.id_column, trackId),
      table: RemoteDatabaseConstants.order_tracking_table,
      select: ShopQueries.orderTracking,
    );
    final order = OrderTrackingModel.fromJson(response);
    return right(order);
  }

  Future<Either<AppException, OrderModel>> cancelOrder(int trackId) async {
    try {
      final response = await _db.UPDATE(
          table: RemoteDatabaseConstants.orders_table,
          idColumn: "track_id",
          id: trackId,
          data: {"status": OrderStatus.cancelled.toDatabase},
          );
      final order = OrderModel.fromJson(response);
         return right(order) ;
    } catch (e) {
      return left(e.toAppException);
    }
  }
  Future<Either<AppException, OrderModel>> deleteOrder(int orderId) async {
    try {
      final response = await _db.UPDATE(
          table: RemoteDatabaseConstants.orders_table,
          id: orderId,
          data: {RemoteDatabaseConstants.is_active_column: false},
          );
      final order = OrderModel.fromJson(response);
         return right(order)  ;
    } catch (e) {
      return left(e.toAppException);
    }
  }

  void subscribeToOrderTracking({
    required int trackId,
    required void Function(OrderTrackingModel tracking) onUpdate,
    void Function(AppException error)? onError,
  }) {
    _channels.add('order_tracking_$trackId');
    _realtime.subscribeToTable(
      channelName: 'order_tracking_$trackId',
      schema: 'public',
      table: RemoteDatabaseConstants.order_tracking_table,
      event: PostgresChangeEvent.update,
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: RemoteDatabaseConstants.id_column,
        value: trackId,
      ),
      // Triggered on every update to the order tracking row
      callback: (payload) async {
        final newData = payload.newRecord;
        // Ignore empty payloads
        if (newData.isEmpty) return;
        // Re-fetch full tracking details to include joined data (e.g. captain profile)
        // since Realtime payloads only return raw columns without foreign key joins
        final result = await getOrderTrackingDetails(trackId);

        result.fold(
              (e) => onError?.call(e), // Propagate fetch error to the caller
              (tracking) =>
              onUpdate.call(tracking), // Emit updated tracking model
        );
      },
    );
  }

  void dispose() {
    for (var channel in _channels) {
      _realtime.unsubscribe(channel);
    }
  }
}