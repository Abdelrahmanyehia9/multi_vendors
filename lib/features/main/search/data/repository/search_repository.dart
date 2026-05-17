import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/database/local_storage.dart';
import 'package:multi_vendor/core/database/local_storage_constants.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/service/database_service.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/core/utils/remote_database_constants.dart';
import 'package:multi_vendor/shared/data/models/product_model.dart';

class SearchRepository {
  final DatabaseService _db;
  final LocalStorage _storage ;

 const SearchRepository(this._db ,this._storage);
  Future<Either<AppException, List<ProductModel>>> searchProducts(
    String query,
  ) async
  {
    try {
      final safeQuery = query.replaceAll(',', r'\,');
      final locale = AppConstants.locale;
      final response  = await _db.GET(table: RemoteDatabaseConstants.product_table,
          filter: (e) => e.or(
              'name->>$locale.ilike.%$safeQuery%,description->>$locale.ilike.%$safeQuery%'
          ).order(RemoteDatabaseConstants.created_at_column).limit(10)
      );
      final products = response.map((e) => ProductModel.fromJson(e)).toList();
      return right(products);
    } catch (e) {
      return left(e.toAppException);
    }
  }
  Future<List<String>> getSearchHistory() async {
    final result = await _storage.read(LocalStorageConstants.searchHistory);
    if (result == null) return [];
    return List<String>.from(result);
  }
  Future<List<String>> saveToSearchHistory(String query) async {
    final old = await getSearchHistory();
    final newHistory = [query, ...old.where((e) => e != query)];
    await _storage.write(LocalStorageConstants.searchHistory, newHistory);
    return newHistory;
  }
  Future<List<String>> removeAtIndex(int index) async {
    final old = await getSearchHistory();
    old.removeAt(index);
    await _storage.write(LocalStorageConstants.searchHistory, old);
    return old;
  }
  Future<List<String>> clearHistory() async {
    await _storage.delete(LocalStorageConstants.searchHistory);
    return [];
  }
}
