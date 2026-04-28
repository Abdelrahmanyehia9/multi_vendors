import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/main/search/data/repository/search_repository.dart';
import 'package:multi_vendor/shared/data/models/product_model.dart';

class SearchProductsCubit extends Cubit<BaseState<List<ProductModel>>>{
  final SearchRepository _repository ;
  SearchProductsCubit(this._repository) : super(const BaseState.initial());
   String? _lastQuery;
  Future<void> search(String? query) async {
    if (query.isNullOrEmpty||query == _lastQuery) return;
    EasyDebounce.debounce(
      'search',
      const Duration(milliseconds: 500),
          () async {
        _lastQuery = query;
        safeEmit(const BaseState.loading());
        final result = await _repository.searchProducts(query!);
        result.fold(
              (l) => safeEmit(BaseState.failure(l)),
              (r) {
            if (r.isEmpty) {
              safeEmit(const BaseState.empty());
            } else {
              safeEmit(BaseState.success(r));
            }
          },
        );
      },
    );
  }


  @override
  Future<void> close() {
    EasyDebounce.cancel('search');
    return super.close();
  }
}
