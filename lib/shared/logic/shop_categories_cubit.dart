import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/main/home/data/repository/home_repository.dart';
import 'package:multi_vendor/shared/data/models/category_model.dart';

class HomeCategoriesCubit extends Cubit<BaseState<List<CategoryModel>>>{
  final HomeRepository _repository;
  HomeCategoriesCubit(this._repository) : super(const BaseState.initial());
  Future<void>getCategories()async{
    safeEmit(const BaseState.loading());
    final result = await _repository.getCategories();
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) {
        if(r.isEmpty) return safeEmit(const BaseState.empty()) ;
        safeEmit(BaseState.success(r));
      },
    );

  }


}