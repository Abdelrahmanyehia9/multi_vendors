import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/shop/rating/data/models/review_model.dart';
import 'package:multi_vendor/features/shop/rating/data/repository/rating_repository.dart';

class OrderSubmitReviewCubit extends Cubit<BaseState<Unit>> {
  final RatingRepository _repository;
  OrderSubmitReviewCubit(this._repository) : super(const BaseState.initial());


  Future<void>submitReviews (List<ReviewModel> reviews)async{
    final validReviews = reviews.where((r) => r.rate != null).toList();
    safeEmit(const BaseState.loading()) ;
    final result = await _repository.rateAnOrder(reviews: validReviews);
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) => safeEmit(BaseState.success(r)),
    );
  }
}