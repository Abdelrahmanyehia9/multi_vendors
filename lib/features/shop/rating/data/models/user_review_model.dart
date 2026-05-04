import 'package:equatable/equatable.dart';
import 'package:multi_vendor/features/shop/rating/data/models/review_model.dart';
import 'package:multi_vendor/shared/data/models/user_model.dart';

class UserReviewModel extends Equatable{
  final UserModel user;
  final ReviewModel review;
 const UserReviewModel({required this.user,
    required this.review});

 factory UserReviewModel.fromJson(Map<String, dynamic>json)=>UserReviewModel(
   user: UserModel.fromJson(json['user']),
   review: ReviewModel.fromJson(json)
 );

 factory UserReviewModel.fake()=>UserReviewModel(
   user: UserModel.fake(),
   review: ReviewModel.fake()
 );

 Map<String, dynamic>toJson()=>{
   'user':user.toJson(),
   'review':review.toJson()
 };

 @override
 List<Object?> get props => [user, review];
}
