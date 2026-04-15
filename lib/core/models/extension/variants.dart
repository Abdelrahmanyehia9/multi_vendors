import 'package:collection/collection.dart';
import 'package:multi_vendor/core/models/variant_attributes_model.dart';
import '../../models/variant_model.dart';
extension VariantExt on List<VariantModel>? {
  Map<String, List<VariantsAttributes>> get availableAttributes {
    final Map<String, List<VariantsAttributes>> result = {};
    for (final variant in this ?? []) {
      for (final attribute in variant.attributes ?? []) {
        result.putIfAbsent(attribute.key, () => []);
        if (!result[attribute.key]!.any((a) => a.value == attribute.value)) {
          result[attribute.key]!.add(attribute);
        }
      }
    }
    return result;
  }

  List<VariantModel> availableVariants(List<VariantsAttributes> filters) {
    if (filters.isEmpty) return this ?? [];
    return this?.where((variant) {
      return filters.every(
            (filter) =>
        variant.attributes?.any((a) => a.value == filter.value) ??
            false,
      );
    }).toList() ??
        [];
  }

  List<VariantsAttributes> availableValuesForKey(
      String key,
      List<VariantsAttributes> currentFilters,
      ) {
    final otherFilters = currentFilters.where((f) => f.key != key).toList();
    final result = <VariantsAttributes>[];
    for (final variant in this ?? []) {
      final matches = otherFilters.every(
            (filter) =>
        variant.attributes?.any((a) => a.value == filter.value) ?? false,
      );
      if (!matches) continue;
      for (final attr in variant.attributes ?? []) {
        if (attr.key == key && !result.any((a) => a.value == attr.value)) {
          result.add(attr);
        }
      }
    }

    return result;
  }
}
extension VariantAttrExt on List<VariantsAttributes>? {
  List<List<VariantsAttributes>> get groupedVariants => this == null
      ? []
      : groupBy(this!, (VariantsAttributes e) => e.key).values.toList();

  static List<VariantsAttributes> expanded(
      List<List<VariantsAttributes>> grouped,
      ) {
    return grouped.expand((g) => g).toList();
  }
}