part of 'product_filters_sheet.dart';

class _StockFilters extends _BaseFilter<StockAvailability> {
  const _StockFilters({required super.items, required super.selected});

  @override
  Widget buildItem(BuildContext context, StockAvailability stock, List<StockAvailability> selectedValues) {
    return AppRadioButton<StockAvailability>(
      multiSelect: true,
      value: stock,
      groupValue: selectedValues,
      onChanged: (_) => toggle(stock),
      label: stock.toText,
    );
  }
}
