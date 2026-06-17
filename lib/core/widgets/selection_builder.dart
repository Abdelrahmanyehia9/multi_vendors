import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/selection_cubit.dart';

class SelectionBuilder<T> extends StatelessWidget {
  final Widget Function(SelectionState<T> state, SelectionCubit<T> bloc) builder ;
  const SelectionBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectionCubit<T>, SelectionState<T>>(
        builder: (context, state) => PopScope(
                canPop: !state.isSelectionMode,
                onPopInvokedWithResult: (didPop, result) {
                  if (!didPop && state.isSelectionMode) {
                    context.read<SelectionCubit<T>>().unselectAll();
                  }
                },
            child: builder(state, context.read<SelectionCubit<T>>())
    ));

  }
}
