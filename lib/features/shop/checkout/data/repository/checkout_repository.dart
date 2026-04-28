import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/service/database_service.dart';
import 'package:multi_vendor/core/utils/remote_database_constants.dart';
import 'package:multi_vendor/core/utils/rpc_functions.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_model.dart';
import 'package:multi_vendor/features/shop/shared/model/order_model.dart';
import 'package:multi_vendor/core/queries/shop_queries.dart';
import 'package:multi_vendor/features/shop/shared/model/checkout_model.dart';
import 'package:multi_vendor/features/shop/checkout/data/model/checkout_request.dart';

class CheckoutRepository {
  final DatabaseService _db;

  CheckoutRepository(this._db);

  Future<Either<AppException, CheckoutSummeryModel>> calculateSummery(
    List<CartModel> items, {
    String? code,
  }) async {
    try {
      final response = await _db.RPC(
        function: RpcFunctions.calculateOrderSummeryRPC,
        params: {'p_cart': items, 'p_promo_code': code},
      );
      final summery = CheckoutSummeryModel.fromJson(response);
      return right(summery);
    } catch (e) {
      return left(e.toAppException);
    }
  }

  Future<Either<AppException, OrderModel>> placeOrder({
    required CheckoutRequest request,
  }) async {
    try {
      final response = await _db.INSERT(
        table: RemoteDatabaseConstants.orders_table,
        select: ShopQueries.orderDetails,
        data: request.toJson(),
      );
      final order = OrderModel.fromJson(response);
      return right(order);
    } catch (e) {
      return left(e.toAppException);
    }
  }
}
