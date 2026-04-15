import 'package:equatable/equatable.dart';

enum VariantType { color, text }
class VariantsAttributes extends Equatable {
  final String key;
  final String value;
  final String? description;
  final VariantType type;

  const VariantsAttributes({
    required this.key,
    required this.value,
    this.description,
    required this.type,
  });

  /// =========================
  /// CORE FACTORY (SAFE)
  /// =========================
  factory VariantsAttributes.fromJson(
      String key,
      Map<String, dynamic> data,
      ) {
    return VariantsAttributes(
      key: key,
      value: data['value']?.toString() ?? '',
      description: data['description']?.toString(),
      type: _resolveType(key),
    );
  }

  /// =========================
  /// TYPE RESOLUTION (CLEAN)
  /// =========================
  static VariantType _resolveType(String key) {
    switch (key.toLowerCase()) {
      case 'color':
      case 'colors':
        return VariantType.color;

      default:
        return VariantType.text;
    }
  }

  /// =========================
  /// FROM MAP (simple attributes)
  /// =========================
  static List<VariantsAttributes> fromAttributesMap(
      Map<String, dynamic> map,
      ) {
    return map.entries
        .map((e) => VariantsAttributes.fromJson(
      e.key,
      e.value as Map<String, dynamic>,
    ))
        .toList();
  }

  /// =========================
  /// FROM FILTER MAP (list inside values)
  /// =========================
  static List<VariantsAttributes> fromFilterMap(
      Map<String, dynamic> map,
      ) {
    final result = <VariantsAttributes>[];

    for (final entry in map.entries) {
      final key = entry.key;
      final values = entry.value;

      if (values is List) {
        for (final item in values) {
          if (item is Map<String, dynamic>) {
            result.add(
              VariantsAttributes.fromJson(key, item),
            );
          }
        }
      }
    }

    return result;
  }

  /// =========================
  /// FROM LIST
  /// =========================
  static List<VariantsAttributes> fromList(
      List<Map<String, dynamic>> data,
      ) {
    return data
        .map((e) => VariantsAttributes(
      key: e['key']?.toString() ?? '',
      value: e['value']?.toString() ?? '',
      description: e['description']?.toString(),
      type: _resolveType(e['key']?.toString() ?? ''),
    ))
        .toList();
  }

  /// =========================
  /// SMART ENTRY POINT
  /// =========================
  static List<VariantsAttributes> fromAny(dynamic data) {
    if (data is List) {
      return fromList(data.cast<Map<String, dynamic>>());
    }

    if (data is Map<String, dynamic>) {
      final firstValue = data.values.isNotEmpty ? data.values.first : null;

      if (firstValue is List) {
        return fromFilterMap(data);
      }

      return fromAttributesMap(data);
    }

    return [];
  }

  /// =========================
  /// JSON
  /// =========================
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
      'description': description,
    }..removeWhere((k, v) => v == null);
  }

  /// =========================
  /// UI HELPERS
  /// =========================
  String get message => "$key : ${description ?? value}";

  bool get isColor => type == VariantType.color;

  @override
  List<Object?> get props => [key, value, description, type];
}
