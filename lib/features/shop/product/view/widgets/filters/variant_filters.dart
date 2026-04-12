// part of 'product_filters_sheet.dart';
//
// class _VariantFilters extends StatelessWidget {
//   final List<List<VariantsAttributes>> groupedVariants;
//   final List<ValueNotifier<List<int>>> activeIndexes;
//
//   const _VariantFilters({required this.groupedVariants, required this.activeIndexes});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: List.generate(groupedVariants.length, (index) {
//         final group = groupedVariants[index];
//         return _FilterItem(
//           ProductVariant.multi(
//             variants: group,
//             activeIndexes: activeIndexes[index],
//           ),
//           title: group.first.key,
//           initiallyExpanded: false,
//         );
//       }),
//     ).paddingHr(8);
//   }
// }