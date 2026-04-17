import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/core/models/product_model.dart';
import 'package:multi_vendor/features/main/search/data/repository/search_repository.dart';

class SearchProductsCubit extends Cubit<BaseState<List<ProductModel>>>{
  final SearchRepository _repository ;
  SearchProductsCubit(this._repository) : super(const BaseState.initial());

   String? _lastQuery;
  Future<void>search(String? query)async{
    if(query.isNullOrEmpty || query == _lastQuery) return ;
    EasyDebounce.debounce('search', const Duration(milliseconds: 800), ()async{
      safeEmit(const BaseState.loading());
      final result = await _repository.searchProducts(query!);
      result.fold(
            (l) => safeEmit(BaseState.failure(l)),
            (r) {
          if(r.isEmpty) return safeEmit(const BaseState.empty());
          safeEmit(BaseState.success(r));
        },
      );
    });
    _lastQuery = query;
  }


  @override
  Future<void> close() {
    EasyDebounce.cancel('search');
    return super.close();
  }
}
