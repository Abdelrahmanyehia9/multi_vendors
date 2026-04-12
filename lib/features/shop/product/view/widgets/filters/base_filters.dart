part of 'product_filters_sheet.dart';

abstract class _BaseFilter<T> extends StatelessWidget {
  final List<T> items;
  final ValueNotifier<List<T>> selected;

  const _BaseFilter({required this.items, required this.selected});

  Widget buildItem(BuildContext context, T item, List<T> selectedValues);

  void toggle(T item) {
    final current = [...selected.value];
    current.contains(item) ? current.remove(item) : current.add(item);
    selected.value = current;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<T>>(
      valueListenable: selected,
      builder: (context, value, child) {
        return Column(
          spacing: 2.h,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: items.map((item) => buildItem(context, item, value)).toList(),
        );
      },
    );
  }
}




