import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/service/database_service.dart';
import 'package:multi_vendor/core/utils/remote_database_constants.dart';
import 'package:multi_vendor/features/main/category/data/model/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryRepository {
  final DatabaseService _db;

  CategoryRepository(this._db);

  Future<Either<AppException, List<CategoryModel>>> getMainCategories() =>
      _getList(
        table: RemoteDatabaseConstants.category_table,
        filter: (e) =>
            e.isFilter("parent", null).order("count", ascending: false),
        fromJson: CategoryModel.fromJson,
      );

  Future<Either<AppException, List<CategoryModel>>> getSubCategories() =>
      _getList(
        table: RemoteDatabaseConstants.category_table,
        filter: (e) => e
            .gt("count", 0)
            .not("parent", "is", null)
            .order("count", ascending: false),
        fromJson: CategoryModel.fromJson,
      );

  Future<Either<AppException, List<T>>> _getList<T>({
    required String table,
    String? select,
    PostgrestTransformBuilder<PostgrestList> Function(
      PostgrestFilterBuilder<PostgrestList>,
    )?
    filter,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await _db.GET(
        table: table,
        select: select,
        filter: filter,
      );
      final data = response.map<T>((e) => fromJson(e)).toList();
      return right(data);
    } catch (e) {
      return left(e.toAppException);
    }
  }
}
