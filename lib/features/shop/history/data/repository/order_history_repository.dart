import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/queries/shop_queries.dart';
import 'package:multi_vendor/core/utils/remote_database_constants.dart';

import '../../../../../core/service/database_service.dart';
import '../../../shared/model/order_model.dart';

class OrderHistoryRepository {
  final DatabaseService _db;

  OrderHistoryRepository(this._db);

  Future<Either<AppException, List<OrderModel>>> getOrdersHistory() async {
    try {
      final response = await _db.GET(
        table: RemoteDatabaseConstants.orders_table,
        select: ShopQueries.orderHistory,
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
}
