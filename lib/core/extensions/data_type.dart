
import 'package:multi_vendor/core/utils/app_configs.dart';

/// String ///
extension StringExtension on String? {
  String removeEmojis() {
    if(this==null) return "";
    return this!.replaceAll(
      RegExp(
        r'[\u{1F600}-\u{1F64F}' // Emoticons
        r'\u{1F300}-\u{1F5FF}' // Misc Symbols and Pictographs
        r'\u{1F680}-\u{1F6FF}' // Transport and Map
        r'\u{1F700}-\u{1F77F}'
        r'\u{1F780}-\u{1F7FF}'
        r'\u{1F800}-\u{1F8FF}'
        r'\u{1F900}-\u{1F9FF}' // Supplemental Symbols and Pictographs
        r'\u{1FA00}-\u{1FA6F}'
        r'\u{1FA70}-\u{1FAFF}'
        r'\u{2600}-\u{26FF}'   // Misc symbols
        r'\u{2700}-\u{27BF}]', // Dingbats
        unicode: true,
      ),
      '',
    );
  }

  bool get isNullOrEmpty => this == null || this == "";
}

extension LocalizedJson on Map<String, dynamic> {
  String get localized =>this[AppConfigs.locale?.languageCode]??this['en']??"" ;
}
/// List ////
extension ListExtension<T> on List<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool  isExists(int index) => !isNullOrEmpty&&index<this!.length;
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
  String get usdPrice => "${(this*AppConfigs.currency.convertToDollar).toStringAsFixed(0)}${AppConfigs.currency.symbol}";
}
extension NumberFormatter on num {
  String get compactNumber {
    if (this >= 1000000000) {
      return "${(this / 1000000000).toStringAsFixed(1)}B";
    }

    if (this >= 1000000) {
      return "${(this / 1000000).toStringAsFixed(1)}M";
    }

    if (this >= 1000) {
      return "${(this / 1000).toStringAsFixed(1)}K";
    }

    return toStringAsFixed(0);
  }
}