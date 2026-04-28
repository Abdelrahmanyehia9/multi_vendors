import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/service/database_service.dart';
import 'package:multi_vendor/core/utils/remote_database_constants.dart';

import 'package:multi_vendor/shared/data/models/news_model.dart';

class NewsRepository {
  final DatabaseService _db;
  NewsRepository(this._db);

  Future<Either<AppException, List<NewsModel>>> getNews({
    String? query,
  }) async {
    try {
      final response = await _db.GET(
        table: RemoteDatabaseConstants.news_table,
        filter: (e) {
          final q = query?.trim();
          if (q == null || q.isEmpty) {
            return e.order(RemoteDatabaseConstants.created_at_column, ascending: false);
          }
          final safe = q.replaceAll(RegExp(r'[,%]'), '');
          return e
              .or('title.ilike.%$safe%,description.ilike.%$safe%')
              .order(RemoteDatabaseConstants.created_at_column, ascending: false);
        },
      );

      return right(
        (response as List).map((e) => NewsModel.fromJson(e)).toList(),
      );
    } catch (e) {
      return left(e.toAppException);
    }
  }
}