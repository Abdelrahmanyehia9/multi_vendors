
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/shop/history/data/model/order_tracking_model.dart';

import 'package:multi_vendor/features/shop/history/data/repository/order_history_repository.dart';

class OrderTrackingCubit extends Cubit<BaseState<OrderTrackingModel>> {
  final OrderHistoryRepository _repository;
  OrderTrackingCubit(this._repository) : super(const BaseState.initial());

  Future<void> orderTracking(int trackID)async{
    safeEmit(const BaseState.loading());
    final result = await _repository.getOrderTrackingDetails(trackID);
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) {
        safeEmit(BaseState.success(r));
        _subscribe(trackID);
      },
    );

  }
  void _subscribe(int trackId){
    _repository.subscribeToOrderTracking(trackId: trackId, onUpdate: (model){
      safeEmit(BaseState.success(model));
    }, onError: (error){
      safeEmit(BaseState.failure(error));
    }) ;
  }

  @override
  Future<void> close() {
    _repository.dispose() ;
    return super.close();
  }
}