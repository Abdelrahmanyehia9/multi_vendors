import 'package:multi_vendor/core/models/price_model.dart';

enum VariantType { color, text }

class VariantModel {
  final String? sku;
  final PriceModel? price;
  final int? inStock;
  final String? images;
  final List<VariantsAttributes>? attributes;

  const VariantModel({
    this.sku,
    this.images,
    this.price,
    this.attributes,
    this.inStock,
  });
  factory VariantModel.fromJson(Map<String, dynamic> json) => VariantModel(
    sku: json['sku'],
    price: PriceModel.fromJson(json['price']),
    inStock: json['stock'],
    images: json['image_url'],
    attributes: json['attributes'] == null
        ? null
        : VariantsAttributes.fromAttributesMap(json['attributes']),
  );

}

class VariantsAttributes {
  final String key;
  final String value;
  final String description;
  final VariantType type;

  VariantsAttributes({
    required this.key,
    required this.value,
    required this.description,
    required this.type,
  });

  factory VariantsAttributes.fromMap(String key, dynamic data) {
    if (key.contains("color") && data is Map) {
      return VariantsAttributes(
        key: key,
        value: data['code'],
        description: data['title'],
        type: VariantType.color,
      );
    }

    return VariantsAttributes(
      key: key,
      value: data.toString(),
      description: data.toString(),
      type: VariantType.text,
    );
  }
  static List<VariantsAttributes> fromAttributesMap(Map<String, dynamic> map) {
    return map.entries
        .map((e) => VariantsAttributes.fromMap(e.key, e.value))
        .toList();
  }

  @override
  String toString() {
    return 'VariantsAttributes(key: $key, value: $value, description: $description, type: $type)';
  }
  String get message => "$key : $description";

}


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
      return filters.every((filter) =>
      variant.attributes?.any((a) => a.value == filter.value) ?? false);
    }).toList() ?? [];
  }

  List<VariantsAttributes> availableValuesForKey(
      String key,
      List<VariantsAttributes> currentFilters,
      ) {
    final otherFilters = currentFilters.where((f) => f.key != key).toList();
    final result = <VariantsAttributes>[];
    for (final variant in this ?? []) {
      final matches = otherFilters.every((filter) =>
      variant.attributes?.any((a) => a.value == filter.value) ?? false);
      if (!matches) continue;
      for (final attr in variant.attributes ?? []) {
        if (attr.key == key &&
            !result.any((a) => a.value == attr.value)) {
          result.add(attr);
        }
      }
    }

    return result;
  }
}