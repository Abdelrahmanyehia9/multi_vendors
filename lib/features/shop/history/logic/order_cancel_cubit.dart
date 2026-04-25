import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';

import '../../../../core/cubit/base_state.dart';
import '../../shared/model/order_model.dart';
import '../data/repository/order_history_repository.dart';

class CancelOrderCubit extends Cubit<BaseState<OrderModel>> {
  final OrderHistoryRepository _repository;
  CancelOrderCubit(this._repository) : super(const BaseState.initial());

  Future<void> cancelOrder(int trackId)async{
    safeEmit(const BaseState.loading()) ;
    final result = await _repository.cancelOrder(trackId);
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) => safeEmit(BaseState.success(r)),
    );
  }
}