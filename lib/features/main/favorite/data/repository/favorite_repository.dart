import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/database/local_storage.dart';
import 'package:multi_vendor/core/database/local_storage_constants.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/features/main/favorite/data/model/favorite_model.dart';

class FavoriteRepository {
  final LocalStorage _localStorage;

  FavoriteRepository(this._localStorage);

  Future<Either<AppException, FavoriteModel>> getFavorite() async {
    try {
      final data = await _localStorage.read(LocalStorageConstants.favorite);
      if (data == null) {
        return right(FavoriteModel(favoriteProducts: [], favoriteVendors: []));
      }
      return right(FavoriteModel.fromJson((data as Map).deepCast));
    } catch (e) {
      return left(e.toAppException);
    }
  }

  Future<void> updateFavorite(FavoriteModel favorite) async {
    await _localStorage.write(
      LocalStorageConstants.favorite,
      favorite.toJson(),
    );
  }
}
