import 'package:easy_localization/easy_localization.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';

enum FavoriteType { product, vendor }

abstract class FavoriteItem {
  int get favoriteId;
  String? get favoriteName;
  FavoriteType get favoriteType;
}

extension FavItemExt on FavoriteItem {
  String get displayName {
    if (favoriteName == null) return AppStrings.item.tr();
    final parts = favoriteName!.split(" ");
    return parts.length > 3
        ? "${parts.take(3).join(" ")}..."
        : parts.join(" ");

}
}