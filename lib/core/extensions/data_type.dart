
import 'dart:ui';

/// String ///
extension StringExtension on String? {
  bool get isNullOrEmpty => this == null || this == "";
}


/// List ////
extension ListExtension<T> on List<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

extension SizeExtension on Size?{
  // double get aspectRatio => this==null ? 0 : width/height;
}