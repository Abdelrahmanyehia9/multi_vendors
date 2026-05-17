import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/service/database_service.dart';
import 'package:multi_vendor/core/utils/remote_database_constants.dart';
import 'package:multi_vendor/features/main/category/data/model/category_model.dart';

class CategoryRepository {
  final DatabaseService _db;

  CategoryRepository(this._db);
  Future<Either<AppException, List<CategoryModel>>> getMainCategories() async {
    try {
      final response = await _db.GET(
        table: RemoteDatabaseConstants.category_table,
        filter: (e) => e.isFilter("parent", null).order("count", ascending: false),
      );
      return right(response.map(CategoryModel.fromJson).toList());
    } catch (e) {
      return left(e.toAppException);
    }
  }

  Future<Either<AppException, List<CategoryModel>>> getSubCategories({int? parentId}) async {
    try {
      final response = await _db.GET(
        table: RemoteDatabaseConstants.category_table,
        filter: (e) => parentId != null
            ? e.gte("count", 0).eq("parent", parentId).order("count", ascending: false)
            : e.gte("count", 0).not("parent", "is", null).order("count", ascending: false),
      );
      return right(response.map(CategoryModel.fromJson).toList());
    } catch (e) {
      return left(e.toAppException);
    }
  }


}
