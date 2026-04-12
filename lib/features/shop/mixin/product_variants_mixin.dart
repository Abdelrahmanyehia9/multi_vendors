import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import '../../../core/models/variant_model.dart';
import '../product/view/widgets/product_variant.dart';

///AI Generated
mixin ProductVariantMixin on State<VariantsSection> {
  late final ValueNotifier<Map<String, VariantsAttributes>> selectedAttributesNotifier =
  ValueNotifier({});

  late  final ValueNotifier<VariantModel?> selectedVariant = widget.selectedVariant;
  List<String> get unselectedAttributes => _availableAttributes.keys
      .where((k) => !selectedAttributes.containsKey(k))
      .toList();
  late final Map<String, ValueNotifier<int>> _indexNotifiers = {
    for (final key in _availableAttributes.keys) key: ValueNotifier(-1),
  };

  late final Map<String, List<VariantsAttributes>> _availableAttributes =
  widget.variants.availableAttributes..removeWhere((_, values) => values.length <= 1);

  Map<String, List<VariantsAttributes>> get availableAttributes => _availableAttributes;

  Map<String, VariantsAttributes> get selectedAttributes => selectedAttributesNotifier.value;
  List<ValueNotifier<int>> get indexNotifiers => _indexNotifiers.values.toList();

  ValueNotifier<int>? indexNotifierForKey(String key) => _indexNotifiers[key];


  void onSelectAttribute(String key, VariantsAttributes attr) {
    final updated = Map<String, VariantsAttributes>.from(selectedAttributes);
    updated[key] = attr;
    selectedAttributesNotifier.value = updated;
    final index = _availableAttributes[key]?.indexOf(attr) ?? -1;
    _indexNotifiers[key]?.value = index;
    _removeInvalidSelections(skip: key);
    _updateSelectedVariant();
  }
  void onDeselectAttribute(String key) {
    final updated = Map<String, VariantsAttributes>.from(selectedAttributes);
    updated.remove(key);
    selectedAttributesNotifier.value = updated;
    _indexNotifiers[key]?.value = -1;
    _updateSelectedVariant();
  }

  List<VariantsAttributes> availableValuesForKey(String key) =>
      widget.variants.availableValuesForKey(
        key,
        selectedAttributes.values.toList(),
      );


  void _removeInvalidSelections({String? skip}) {
    final updated = Map<String, VariantsAttributes>.from(selectedAttributes);
    bool changed = false;

    for (final key in updated.keys.toList()) {
      if (key == skip) continue;

      final stillAvailable = availableValuesForKey(key)
          .any((e) => e.value == updated[key]?.value);

      if (!stillAvailable) {
        updated.remove(key);
        _indexNotifiers[key]?.value = -1;
        changed = true;
      }
    }

    if (changed) {
      selectedAttributesNotifier.value = updated;
    }
  }

  void _updateSelectedVariant() {
    final requiredCount = _availableAttributes.keys
        .where((k) => availableValuesForKey(k).isNotEmpty)
        .length;
    if (selectedAttributes.length != requiredCount) {
      selectedVariant.value = null;
      return;
    }
    selectedVariant.value = widget.variants
        .availableVariants(selectedAttributes.values.toList())
        .firstOrNull;
  }


  @override
  void dispose() {
    selectedAttributesNotifier.dispose();
    for (final n in _indexNotifiers.values) {
      n.dispose();
    }
    super.dispose();
  }
}