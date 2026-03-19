import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';

final class SearchState {
  final String query;
  final bool hasFocus;

  SearchState({
    required this.query,
    required this.hasFocus,
  });

  SearchState copyWith({
    String? query,
    bool? hasFocus,
  }) {
    return SearchState(
      query: query ?? this.query,
      hasFocus: hasFocus ?? this.hasFocus,
    );
  }
}


class SearchCubit extends Cubit<SearchState> {
  late final TextEditingController controller;
  late final FocusNode focusNode;
  SearchCubit() : super(SearchState(query: '', hasFocus: false)){
  init() ;
  }

  void init(){
    focusNode = FocusNode()..requestFocus();
    controller = TextEditingController();
    focusNode.addListener(() => onFocusChanged(focusNode.hasFocus));
    controller.addListener(() => onQueryChanged(controller.text));
  }
  void onFocusChanged(bool focused) {
    safeEmit(state.copyWith(hasFocus: focused));
  }
  void onQueryChanged(String query) {
    safeEmit(state.copyWith(query: query));
  }


  @override
  Future<void> close() {
    focusNode.dispose();
    controller.dispose();
    return super.close();
  }
}