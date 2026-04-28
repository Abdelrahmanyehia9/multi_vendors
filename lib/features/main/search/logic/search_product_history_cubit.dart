import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';

import 'package:multi_vendor/features/main/search/data/repository/search_repository.dart';

class SearchProductHistoryCubit extends Cubit<BaseState<List<String>>> {
  final SearchRepository _repository;
  SearchProductHistoryCubit(this._repository) : super(const BaseState.initial());

  Future<void>getHistory()async{
    safeEmit(const BaseState.loading());
    final result = await _repository.getSearchHistory();
    safeEmit(BaseState.success(result));
  }
  Future<void>saveToHistory(String? query)async{
    if(query.isNullOrEmpty)return ;
   final history=  await _repository.saveToSearchHistory(query!);
   safeEmit(BaseState.success(history));
  }
  Future<void>onRemoveItem(int index)async{
    final history=  await _repository.removeAtIndex(index);
    safeEmit(BaseState.success(history));
  }
  Future<void>onRemoveAll()async{
    final history=  await _repository.clearHistory();
    safeEmit(BaseState.success(history));
  }
}