part of 'product_filters_sheet.dart';

class _PriceFilter extends StatelessWidget {
  final ValueNotifier<RangeValues?> priceRange;
  final RangeValues availableRange ;
  const _PriceFilter({required this.priceRange,required this.availableRange});


  @override
  Widget build(BuildContext context) {
    return RangeInput(
      rangeNotifier: priceRange,
      range: availableRange,
      type: RangeInputType.wheel,
    ) ;
  }
}
