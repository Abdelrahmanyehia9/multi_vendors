import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/shop/history/data/repository/order_history_repository.dart';

import '../../shared/model/order_model.dart';

class OrderHistoryCubit extends Cubit<BaseState<List<OrderModel>>> {
  final OrderHistoryRepository _repository;

  OrderHistoryCubit(this._repository) : super(const BaseState.initial());

  Future<void> getOrdersHistory() async {
    safeEmit(const BaseState.loading());
    final result = await _repository.getOrdersHistory();
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) {
        if(r.isEmpty) return safeEmit(const BaseState.empty()) ;
        safeEmit(BaseState.success(r));
      },
    );
  }
}
