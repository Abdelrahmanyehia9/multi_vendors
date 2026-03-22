import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'local_storage.dart';

class SharedPrefLocalStorage implements LocalStorage {
  final SharedPreferences _prefs;

  SharedPrefLocalStorage(this._prefs);

  static Future<SharedPrefLocalStorage> create() async =>
      SharedPrefLocalStorage(await SharedPreferences.getInstance());

  @override
  Future<void> write(String key, dynamic value) async {
    switch (value) {
      case String v:  await _prefs.setString(key, v);
      case int v:     await _prefs.setInt(key, v);
      case bool v:    await _prefs.setBool(key, v);
      case double v:  await _prefs.setDouble(key, v);
      case Map v:     await _prefs.setString(key, jsonEncode(v));
      case List v:    await _prefs.setString(key, jsonEncode(v));
      default: throw UnsupportedError('Type ${value.runtimeType} is not supported');
    }
  }

  @override
  dynamic read(String key, {dynamic defaultValue}) {
    final value = _prefs.get(key);
    if (value is String) {
      try {
        final decoded = jsonDecode(value);
        if (decoded is Map || decoded is List) return decoded;
      } catch (_) {}
    }
    return value ?? defaultValue;
  }

  @override
  Future<void> delete(String key) async => _prefs.remove(key);

  @override
  Future<void> clear() async => _prefs.clear();

  @override
  bool containsKey(String key) => _prefs.containsKey(key);
}