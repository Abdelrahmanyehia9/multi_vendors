import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/service/database_service.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/core/utils/remote_database_constants.dart';
import 'package:multi_vendor/features/news/data/model/news_model.dart';

class NewsRepository {
  final DatabaseService _db;
  NewsRepository(this._db);

  Future<Either<AppException, List<NewsModel>>> getNews({String? query}) async {
    try {
      final response = await _db.GET(
        table: RemoteDatabaseConstants.news_table,
        filter: (e) {
          final q = query?.trim();
          final base = e.order(RemoteDatabaseConstants.created_at_column, ascending: false);
          if (q == null || q.isEmpty) return base;
          final safeQuery = q.replaceAll(',', r'\,');
          final locale = AppConstants.locale;
          return e
              .or('title->>$locale.ilike.%$safeQuery%,description->>$locale.ilike.%$safeQuery%')
              .order(RemoteDatabaseConstants.created_at_column, ascending: false);
        },
      );

      return right((response as List).map((e) => NewsModel.fromJson(e)).toList());
    } catch (e) {
      return left(e.toAppException);
    }
  }
}