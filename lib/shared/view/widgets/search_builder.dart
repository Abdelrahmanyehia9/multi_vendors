import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/shared/logic/search_cubit.dart';

class SearchBuilder extends StatelessWidget {
  final Widget? resultBuilder ;
  final Widget Function(String query,  bool hasFocus) builder ;
  const SearchBuilder({super.key, this.resultBuilder, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state){
          if (state.query.isNotEmpty) {
            return resultBuilder ?? builder.call(state.query, state.hasFocus) ;
          }
          return builder.call( state.query,  state.hasFocus) ;
        }
    );
  }
}
