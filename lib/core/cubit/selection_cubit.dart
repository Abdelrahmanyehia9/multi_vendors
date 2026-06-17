import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';

class SelectionCubit<T> extends Cubit<SelectionState<T>> {
  SelectionCubit() : super(SelectionState<T>());

  void toggle(T item) {
    final updated = Set<T>.from(state.selected);
    updated.contains(item) ? updated.remove(item) : updated.add(item);
    safeEmit(state.copyWith(selected: updated));
  }

  void selectAll(List<T> items) =>
      safeEmit(state.copyWith(selected: Set<T>.from(items)));
  void unselectAll() => safeEmit(state.copyWith(selected: {}));
  void clear() => safeEmit(state.copyWith(selected: {}));
}

class SelectionState<T> {
  final Set<T> selected;
  SelectionState({Set<T>? selected}) : selected = selected ?? {};
  bool get isSelectionMode => selected.isNotEmpty;
  bool isSelected(T item) => selected.contains(item);
  int get count => selected.length;
  bool  isAllSelected(List<T> items) => selected.length == items.length;
  SelectionState<T> copyWith({Set<T>? selected}) => SelectionState(selected: selected ?? this.selected);
}