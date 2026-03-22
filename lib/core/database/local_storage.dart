abstract class LocalStorage {
  Future<void> write(String key, dynamic value);
  dynamic read(String key, {dynamic defaultValue});
  Future<void> delete(String key);
  Future<void> clear();
  bool containsKey(String key);
}