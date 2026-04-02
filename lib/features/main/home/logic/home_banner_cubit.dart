import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/main/home/data/models/home_banner_model.dart';

import '../../../../core/cubit/base_state.dart';
import '../data/repository/home_repository.dart';

class HomeBannerCubit extends Cubit<BaseState<List<HomeBannerModel>>> {
  final HomeRepository _repository;
  HomeBannerCubit(this._repository) : super(const BaseState.initial());


  Future<void> getBanners()async{
    safeEmit(const BaseState.loading());
    final result = await _repository.getBanners();
    result.fold(
          (l) => safeEmit(BaseState.failure(l)),
          (r) {
        if(r.isEmpty) return safeEmit(const BaseState.empty());
        safeEmit(BaseState.success(r));
      },
    );
  }
}