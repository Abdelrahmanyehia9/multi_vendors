import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/service/database_service.dart';
import 'package:multi_vendor/core/utils/rpc_functions.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_model.dart';
import '../../../shared/model/checkout_model.dart';

class CheckoutRepository {

  final DatabaseService _db  ;
  CheckoutRepository(this._db);

  Future<Either<AppException , CheckoutSummeryModel>>calculateSummery(List<CartModel>items, {String? code})async{
    try{
      final response  = await _db.RPC(function: RpcFunctions.calculateOrderSummeryRPC, params: {
        'p_cart': items,
        'p_promo_code': code
      }) ;
      final summery = CheckoutSummeryModel.fromJson(response);
      return right(summery);
    }catch(e){return left(e.toAppException); }


  }

}