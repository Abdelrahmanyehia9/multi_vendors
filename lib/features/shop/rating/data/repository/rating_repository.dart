import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/queries/shop_queries.dart';
import 'package:multi_vendor/core/service/database_service.dart';
import 'package:multi_vendor/core/utils/remote_database_constants.dart';
import 'package:multi_vendor/features/shop/rating/data/models/review_model.dart';
import 'package:multi_vendor/features/shop/rating/data/models/user_review_model.dart';

class RatingRepository {
  final DatabaseService _db;

  const RatingRepository(this._db);
  Future<Either<AppException, Unit>> rateAnOrder({
    required List<ReviewModel> reviews,
  }) async {
    try {
      await _db.UPSERT_MANY(
        table: RemoteDatabaseConstants.reviews_table,
        data: reviews.map((e) => e.toJson()).toList(),
      );
      return right(unit);
    } catch (e) {
      return left(e.toAppException);
    }
  }
  Future<Either<AppException, List<UserReviewModel>>> getUserReviews({
    required int productId,
    int? value,
  }) async
  {
    try {
      final response = await _db.GET(
        table: RemoteDatabaseConstants.reviews_table,
        select: ShopQueries.userReviews,filter: (q) {
        var query = q.eq(RemoteDatabaseConstants.product_id_column, productId);
        if (value != null) {
          query = query.eq("value", value);
        }
        return query;
      },
      );
    final reviews = response.map((e) => UserReviewModel.fromJson(e)).toList();
    return right(reviews);

    } catch (e) {
      return left(e.toAppException);
    }
  }
}
