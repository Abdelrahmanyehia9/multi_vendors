import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:multi_vendor/core/database/local_storage.dart';

class HiveLocalStorage implements LocalStorage {
  final String boxName;
  HiveLocalStorage(this.boxName);
  Box get _box => Hive.box(boxName);
  static Future<void> init() async {
    await Hive.initFlutter();
  }

  static Future<void> openBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox(boxName);
    }
  }

  @override
  Future<void> write(String key, dynamic value) async {
    await _box.put(key, value);
  }

  @override
  dynamic read(String key, {dynamic defaultValue}) {
    return _box.get(key, defaultValue: defaultValue);
  }

  @override
  Future<void> delete(String key) async {
    await _box.delete(key);
  }

  @override
  Future<void> clear() async {
    await _box.clear();
  }

  @override
  bool containsKey(String key) => _box.containsKey(key);
}