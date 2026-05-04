import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/features/shop/rating/logic/user_reviews_cubit.dart';
import 'package:multi_vendor/features/shop/rating/view/reviews_screen.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/shared/data/models/rating_model.dart';

mixin ReviewScreenMixin on State<ReviewsScreen> {
  final ValueNotifier<int?> selected = ValueNotifier<int?>(null);
 RatingModel? get rating => widget.model.rating ;
 UserReviewsCubit get _cubit => context.read<UserReviewsCubit>();

  @override
  void initState() {
    super.initState();
    selected.addListener(_setupTabsListener) ;
  }
 Future<void>_setupTabsListener()async{
  _cubit.getUserReviews(value: selected.value) ;
 }


  @override
  void dispose() {
    selected.dispose();
    super.dispose();
  }
}