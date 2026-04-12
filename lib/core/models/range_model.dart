import 'package:flutter/material.dart';
import 'package:multi_vendor/core/utils/helper/fake_data.dart';

class RangeModel {
  final num min;
  final num max;

  const RangeModel({required this.min, required this.max});

  factory RangeModel.fromJson(Map<String, dynamic> json) =>
      RangeModel(min: json['min'], max: json['max']);
  factory RangeModel.fake() => const RangeModel(min: FakeData.fakeInt, max: FakeData.fakeInt);
  Map<String, dynamic> toJson() => {'min': min, 'max': max};
  RangeModel copyWith({int? min, int? max}) =>
      RangeModel(min: min ?? this.min, max: max ?? this.max);
  RangeValues toRangeValues() => RangeValues(min.toDouble(), max.toDouble());


  @override
  String toString() {
    return 'min: $min | max: $max';
  }
}
