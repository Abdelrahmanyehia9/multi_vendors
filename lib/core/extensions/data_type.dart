
/// String ///
extension StringExtension on String? {
  bool get isNullOrEmpty => this == null || this == "";
}


/// List ////
extension ListExtension<T> on List<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

extension RemoveNulls on Map<String, dynamic> {
  Map<String, dynamic> withoutNulls() {
    return Map.fromEntries(
      entries.where(
            (e) => e.value != null && (e.value is! String || e.value.isNotEmpty),
      ),
    );
  }
}