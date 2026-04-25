import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/shop/history/data/repository/order_history_repository.dart';
import 'package:multi_vendor/features/shop/shared/model/order_model.dart';

class OrderDeleteCubit extends Cubit<BaseState<OrderModel>> {
  final OrderHistoryRepository _repository ;
  OrderDeleteCubit(this._repository) : super(const BaseState.initial());
  Future<void> deleteOrder(int orderId)async{
    safeEmit(const BaseState.loading());
    final result = await _repository.deleteOrder(orderId);
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) => safeEmit(BaseState.success(r)),
    );

  }
}