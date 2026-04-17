import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/service/database_service.dart';
import 'package:multi_vendor/core/utils/rpc_functions.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_model.dart';
import 'package:multi_vendor/features/shop/cart/data/models/promo_code_model.dart';

class PromoCodeRepository {
  final DatabaseService _db;

  PromoCodeRepository(this._db);

  Future<Either<AppException, PromoCardResponse>> validatePromo({
    required List<CartModel> cart,
    required String code,
  }) async {
    try {
      final response = await _db.RPC(
        function: RpcFunctions.calculatePromoRPC,
        params: {"p_code": code, "p_cart_total": cart.totalPrice},
      );
      final result = PromoCardResponse.fromJson(response);
      return right(result);
    } catch (e) {
      return left(e.toAppException);
    }
  }
}
