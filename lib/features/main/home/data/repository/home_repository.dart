import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/enum/product_tags.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/models/base_category_model.dart';
import 'package:multi_vendor/core/models/news_model.dart';
import 'package:multi_vendor/core/models/product_model.dart';
import 'package:multi_vendor/core/service/database_service.dart';
import 'package:multi_vendor/core/utils/remote_database_constants.dart';
import 'package:multi_vendor/features/main/home/data/models/home_banner_model.dart';
import 'package:multi_vendor/features/main/home/data/models/home_vendor_model.dart';
import 'package:multi_vendor/features/main/home/data/models/product_tag_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/queries/home_queries.dart';

class HomeRepository {
  final DatabaseService _databaseService;
  HomeRepository(this._databaseService);


  Future<Either<AppException, List<T>>> _getList<T>({
    required String table,
    String? select,
  PostgrestTransformBuilder<PostgrestList> Function(PostgrestFilterBuilder<PostgrestList>)? filter,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await _databaseService.GET(
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
  Future<Either<AppException, List<CategoryModel>>> getCategories() =>
     _getList(
      table: RemoteDatabaseConstants.category_table,
      select: HomeQueries.homeCategories,
      fromJson: CategoryModel.fromJson,
    );
  Future<Either<AppException, List<HomeVendorModel>>> getVendors() =>
     _getList(
      table: RemoteDatabaseConstants.vendor_table,
      select: HomeQueries.homeVendors,
      fromJson: HomeVendorModel.fromJson,
    );
  Future<Either<AppException, List<ProductModel>>> getProductByCategory({
    required int catId,
  }) => _getList(
      table: RemoteDatabaseConstants.product_table,
      select: HomeQueries.productByCategory,
      filter: (e) =>
          e.eq(RemoteDatabaseConstants.category_id_column, catId),
      fromJson: ProductModel.fromJson,
    );
  Future<Either<AppException, List<ProductModel>>> getItemByFilter(
      ProductTags tag, {
        int limit = 1,
      }) => _getList(
      table: RemoteDatabaseConstants.product_table,
      select: HomeQueries.productByFilter,
      filter: (q) => tag.filters(q).limit(limit),
      fromJson: ProductModel.fromJson,
    );
  Future<Either<AppException, List<ProductTagModel>>> getTagsInfo() =>
    _getList(
      table: RemoteDatabaseConstants.tags_table,
      filter: (e)=>e.limit(4),
      fromJson: ProductTagModel.fromJson,
    );
  Future<Either<AppException, List<NewsModel>>> getNews() => _getList(
      table: RemoteDatabaseConstants.news_table,
      filter: (e) => e.order(
        RemoteDatabaseConstants.created_at_column,
        ascending: true,
      ),
      fromJson: NewsModel.fromJson,
    );
  Future<Either<AppException, List<HomeBannerModel>>> getBanners() => _getList(
      table: RemoteDatabaseConstants.banner_table,
      filter: (e) => e
          .eq(RemoteDatabaseConstants.is_active_column, true)
          .order(
        RemoteDatabaseConstants.created_at_column,
        ascending: true,
      ),
      fromJson: HomeBannerModel.fromJson,
    );

}