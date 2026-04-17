import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/shop/checkout/data/repository/checkout_repository.dart';

import '../../cart/data/models/cart_model.dart';
import '../../shared/model/checkout_model.dart';

class CheckoutSummeryCubit extends Cubit<BaseState<CheckoutSummeryModel>> {
  final CheckoutRepository _repository ;
  CheckoutSummeryCubit(this._repository) : super(const BaseState.initial());


  Future<void>calculateSummery(List<CartModel>items, {String? code})async{
    safeEmit(const BaseState.loading());
    final result = await _repository.calculateSummery(items, code: code);
    result.fold((l) => safeEmit(BaseState.failure(l)), (r) => safeEmit(BaseState.success(r)));
  }

}
