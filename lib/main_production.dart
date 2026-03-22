// import 'local_storage.dart';
// import 'hive_local_storage.dart';
// // import 'shared_pref_local_storage.dart'; // ← البديل الجاهز
//
// // ============================================================
// // 4. الـ Repository — ما يعرفش Hive موجود
// //    بيتكلم مع LocalStorage بس
// // ============================================================
//
// class AuthRepository {
//   final LocalStorage _storage;
//
//   AuthRepository(this._storage); // ← يستقبل الـ interface مش Hive
//
//   Future<void> saveToken(String token) =>
//       _storage.write('access_token', token);
//
//   String? getToken() => _storage.read('access_token');
//
//   bool get isLoggedIn => _storage.containsKey('access_token');
//
//   Future<void> logout() => _storage.delete('access_token');
// }
//
// class SettingsRepository {
//   final LocalStorage _storage;
//
//   SettingsRepository(this._storage);
//
//   Future<void> setTheme(String theme) => _storage.write('theme', theme);
//   String getTheme() => _storage.read('theme', defaultValue: 'light');
//
//   Future<void> setLanguage(String lang) => _storage.write('language', lang);
//   String getLanguage() => _storage.read('language', defaultValue: 'ar');
// }
//
//
// // ============================================================
// // 5. main.dart — نقطة التحكم الوحيدة
// //    لو عايز تغير Hive بأي حاجة تانية،
// //    بتعدل سطر واحد بس هنا
// // ============================================================
//
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //
// //   // ── الـ Storage (غيّر هنا بس لو بدلت الـ provider) ──
// //   await HiveLocalStorage.init();
// //   await HiveLocalStorage.openBox('app_box');
// //   final LocalStorage storage = HiveLocalStorage('app_box');
// //
// //   // لو عايز تجرب SharedPreferences بدلاً من Hive:
// //   // final LocalStorage storage = await SharedPrefLocalStorage.create();
// //
// //   // ── الـ Repositories (ما اتغيروش) ──────────────────
// //   final auth     = AuthRepository(storage);
// //   final settings = SettingsRepository(storage);
// //
// //   runApp(MyApp(auth: auth, settings: settings));
// // }
//
//
// // ============================================================
// // ملخص: لو عايز تشيل Hive غداً
// // ============================================================
// //
// //  قبل (Hive):
// //    final LocalStorage storage = HiveLocalStorage('app_box');
// //
// //  بعد (SharedPreferences):
// //    final LocalStorage storage = await SharedPrefLocalStorage.create();
// //
// //  بعد (SQLite أو أي حاجة):
// //    final LocalStorage storage = SQLiteLocalStorage('app.db');
// //    // وبتعمل SQLiteLocalStorage implements LocalStorage
// //
// //  باقي المشروع صفر تعديلات.
// // ============================================================