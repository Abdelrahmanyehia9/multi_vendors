import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';

mixin LocalCubitSearch<T> on Cubit<BaseState<List<T>>> {
  List<T> get items;
  List<String Function(T)> get searchFields;

  void onSearch(String? query) {
    if(items.isEmpty)return ;
    if (query.isNullOrEmpty) {
      return safeEmit(BaseState.success(items));
    }
    final lowerQuery = query!.toLowerCase();
    final result = items.where((element) {
      return searchFields.any((field) {
        final value = field(element);
        return value.toLowerCase().contains(lowerQuery);
      });
    }).toList();
    if (result.isEmpty) {
      return safeEmit(const BaseState.empty());
    }

    safeEmit(BaseState.success(result));
  }
}