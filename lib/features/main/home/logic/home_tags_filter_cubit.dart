





import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/main/home/data/repository/home_repository.dart';

import 'package:multi_vendor/features/main/home/data/models/product_tag_model.dart';

class HomeTagsFilterCubit extends Cubit<BaseState<List<ProductTagModel>>> {
  final HomeRepository _repository;
  HomeTagsFilterCubit(this._repository) : super(const BaseState.initial());


  Future<void> getTags()async{
    safeEmit(const BaseState.loading());
    final result = await _repository.getTagsInfo();
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) {
        if(r.isEmpty) return safeEmit(const BaseState.empty());
        safeEmit(BaseState.success(r));
      },
    );
  }
}