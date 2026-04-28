
import 'package:multi_vendor/core/database/hive_local_storage.dart';
import 'package:multi_vendor/core/database/local_storage.dart';
import 'package:multi_vendor/core/database/local_storage_constants.dart';

class HiveHelper {
  HiveHelper._();

  static late final LocalStorage user;
  static late final LocalStorage cart;
  static late final LocalStorage favorite;
  static late final LocalStorage searchHistory;

  static Future<void> init() async {
    await HiveLocalStorage.init();
    await Future.wait([
      HiveLocalStorage.openBox(HiveBoxes.userBox),
      HiveLocalStorage.openBox(HiveBoxes.cartBox),
      HiveLocalStorage.openBox(HiveBoxes.favoriteBox),
      HiveLocalStorage.openBox(HiveBoxes.searchHistoryBox),
    ]);

    user = HiveLocalStorage(HiveBoxes.userBox);
    cart = HiveLocalStorage(HiveBoxes.cartBox);
    favorite = HiveLocalStorage(HiveBoxes.favoriteBox);
    searchHistory = HiveLocalStorage(HiveBoxes.searchHistoryBox);
  }

  static Future<void> clearAll() => Future.wait([
    user.clear(),
    cart.clear(),
    favorite.clear(),
    searchHistory.clear(),
  ]);
}