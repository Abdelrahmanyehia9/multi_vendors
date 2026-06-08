import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/core/utils/app_configs.dart';
import 'package:multi_vendor/features/main/home/data/repository/home_repository.dart';

import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/shared/data/models/product_model.dart';

class HomeFeaturedItemCubit extends Cubit<BaseState<ProductModel>> {
  final HomeRepository _repository  ;
  HomeFeaturedItemCubit(this._repository) : super(const BaseState.initial());

  Future<void>getFeaturedItem()async{
  safeEmit(const BaseState.loading());
  final result = await _repository.getItemByFilter(AppConfigs.homeFeaturedItem);
  result.fold(
    (l) => safeEmit(BaseState.failure(l)),
    (r) {
      if(r.isEmpty)return safeEmit(const BaseState.empty());
      safeEmit(BaseState.success(r.first));
    },
  );
  }


}