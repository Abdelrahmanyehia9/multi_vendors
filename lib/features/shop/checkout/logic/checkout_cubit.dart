import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/shop/checkout/data/model/checkout_request.dart';
import 'package:multi_vendor/features/shop/shared/model/order_model.dart';
import 'package:multi_vendor/features/shop/checkout/data/repository/checkout_repository.dart';

class CheckoutCubit extends Cubit<BaseState<OrderModel>>{
  final CheckoutRepository _repository ;
  CheckoutCubit(this._repository) : super(const BaseState.initial());


  Future<void>placeAnOrder(CheckoutRequest request)async{
    safeEmit(const BaseState.loading());
    final result  = await _repository.placeOrder(request: request) ;
    return result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) => safeEmit(BaseState.success(r))
    );
  }

}