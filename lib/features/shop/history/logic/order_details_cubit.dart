import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/shop/shared/model/order_model.dart';

import '../../../../core/cubit/base_state.dart';
import '../data/repository/order_history_repository.dart';

class OrderDetailsCubit extends Cubit<BaseState<OrderModel>> {
  final OrderHistoryRepository _repository;
  OrderDetailsCubit(this._repository) : super(const BaseState.initial());


  Future<void> getXOrderDetails(int orderId)async{
    safeEmit(const BaseState.loading());
    final result = await _repository.getOrderDetails(orderId);
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) => safeEmit(BaseState.success(r)),
    );
  }
}