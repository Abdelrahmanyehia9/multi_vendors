
/// String ///
extension StringExtension on String? {
  bool get isNullOrEmpty => this == null || this == "";
}


/// List ////
extension ListExtension<T> on List<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}
extension IterableX<T> on Iterable<T?> {
  Iterable<T> whereNotNull() sync* {
    for (final e in this) {
      if (e != null) yield e;
    }
  }
}

extension RemoveNulls on Map<String, dynamic> {
  Map<String, dynamic> get withoutNulls {
    return Map.fromEntries(
      entries.where(
            (e) => e.value != null && (e.value is! String || e.value.isNotEmpty) && (e.value is! List || e.value.isNotEmpty),
      ),
    );
  }
}
extension MapEXt on Map{


  Map<String,dynamic> get deepCast{
    return map((key, value) {
      if (value is Map) return MapEntry(key.toString(), value.deepCast);
      if (value is List) return MapEntry(key.toString(), value.map((e) => e is Map ? e.deepCast : e).toList());
      return MapEntry(key.toString(), value);
    });
  }

}



extension PriceExtension on num{
  String get usdPrice => "${toString()}\$";
}