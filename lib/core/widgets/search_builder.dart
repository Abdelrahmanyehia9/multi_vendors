import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/search_cubit.dart';

class SearchBuilder extends StatelessWidget {
  final Widget? resultBuilder ;
  final Widget builder ;
  const SearchBuilder({super.key, this.resultBuilder, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state){
          if (state.query.isNotEmpty) {
            return resultBuilder ?? builder ;
          }
          return builder ;
        }
    );
  }
}
