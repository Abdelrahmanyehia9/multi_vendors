import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/main/home/data/repository/home_repository.dart';
import 'package:multi_vendor/features/shop/shared/model/order_model.dart';

class HomeOnGoingOrderCubit extends Cubit<BaseState<List<OrderModel>>> {
  final HomeRepository _repository;
  HomeOnGoingOrderCubit(this._repository) : super(const BaseState.initial());
  Future<void> getOnGoing() async {
    safeEmit(const BaseState.loading());
    final result = await _repository.getOnGoingOrder();
    result.fold(
          (_) {},
          (items) {
        if (items.isEmpty) return safeEmit(const BaseState.empty()) ;
          safeEmit(BaseState.success(items));
      },
    );
  }
}