import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/enum/product_tags.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/models/base_category_model.dart';
import 'package:multi_vendor/core/models/news_model.dart';
import 'package:multi_vendor/core/models/product_model.dart';
import 'package:multi_vendor/core/service/database_service.dart';
import 'package:multi_vendor/core/utils/remote_database_constants.dart';
import 'package:multi_vendor/features/main/home/data/models/home_vendor_model.dart';
import 'package:multi_vendor/features/main/home/data/models/product_tag_model.dart';
import 'home_quieries.dart';

class HomeRepository {
  final DatabaseService _databaseService;

  HomeRepository(this._databaseService);

  final HomeQueries _queries = HomeQueries();

  Future<Either<AppException, List<CategoryModel>>> getCategories() async {
    try {
      final response = await _databaseService.GET(
        table: RemoteDatabaseConstants.category_table,
        select: _queries.homeCategories,
      );
      final List<CategoryModel> categories = response
          .map((e) => CategoryModel.fromJson(e))
          .toList();
      return right(categories);
    } catch (e) {
      return left(e.toAppException);
    }
  }

  Future<Either<AppException, List<HomeVendorModel>>> getVendors() async {
    try {
      final response = await _databaseService.GET(
        table: RemoteDatabaseConstants.vendor_table,
        select: _queries.homeVendors,
      );
      final List<HomeVendorModel> vendors = response
          .map((e) => HomeVendorModel.fromJson(e))
          .toList();
      return right(vendors);
    } catch (e) {
      return left(e.toAppException);
    }
  }

  Future<Either<AppException, List<ProductModel>>> getProductByCategory({
    required int catId,
  }) async {
    try {
      final response = await _databaseService.GET(
        table: RemoteDatabaseConstants.product_table,
        select: _queries.productByCategory,
        filter: (e) => e.eq(RemoteDatabaseConstants.category_id_column, catId),
      );
      final List<ProductModel> products = response
          .map((e) => ProductModel.fromJson(e))
          .toList();
      return right(products);
    } catch (e) {
      return left(e.toAppException);
    }
  }

  Future<Either<AppException, List<ProductModel>>> getItemByFilter(
    ProductTags tag, {
    int limit = 1,
  }) async {
    try {
      final response = await _databaseService.GET(
        table: RemoteDatabaseConstants.product_table,
        select: _queries.productByFilter,
        filter: (q) => tag.filters(q).limit(limit),
      );
      final List<ProductModel> products = response
          .map((e) => ProductModel.fromJson(e))
          .toList();
      return right(products);
    } catch (e) {
      return left(e.toAppException);
    }
  }

  Future<Either<AppException, List<ProductTagModel>>> getTagsInfo() async {
    try {
      final response = await _databaseService.GET(table: RemoteDatabaseConstants.tags_table,);
      final List<ProductTagModel> tags = response
          .map((e) => ProductTagModel.fromJson(e))
          .toList();
      return right(tags);
    } catch (e) {
      return left(e.toAppException);
    }
  }

  Future<Either<AppException, List<NewsModel>>> getNews() async {
    try {
      final response = await _databaseService.GET(table: RemoteDatabaseConstants.news_table,
      filter: (e)=>e.order(RemoteDatabaseConstants.created_at_column, ascending: true)
      );
      final List<NewsModel> news = response
          .map((e) => NewsModel.fromJson(e))
          .toList();
      return right(news);
    } catch (e) {
      return left(e.toAppException);
    }
  }
}
