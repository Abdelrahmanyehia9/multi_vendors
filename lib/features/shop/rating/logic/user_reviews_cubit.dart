import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/shop/rating/data/models/user_review_model.dart';
import 'package:multi_vendor/features/shop/rating/data/repository/rating_repository.dart';

class UserReviewsCubit extends Cubit<BaseState<List<UserReviewModel>>> {
  final RatingRepository _repository;
  final int productID;
  UserReviewsCubit(this._repository,this.productID) : super(const BaseState.initial());



  Future<void>getUserReviews({int? value})async{
    safeEmit(const BaseState.loading());
    final result = await _repository.getUserReviews(productId: productID, value: value,);
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) {
        if(r.isEmpty) return safeEmit(const BaseState.empty());
        safeEmit(BaseState.success(r));
      },
    );
  }
}