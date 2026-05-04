import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/date_time.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/features/shop/rating/data/models/user_review_model.dart';
import 'package:multi_vendor/shared/view/widgets/user_avatar.dart';

class ProductUserReviewCard extends StatelessWidget {
  final UserReviewModel model;
  const ProductUserReviewCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final user = model.user;
    final review = model.review;
    final username = user.id == userCubit.user?.id ? "You" : user.fullName??"Unknown";
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: context.isDark ? AppColors.grey800 : AppColors.white,
        borderRadius: BorderRadius.circular(Decorations.borderRadius8.w),
      ),
      child: Column(
        spacing: 5.h,
        children: [
          Row(
            spacing: 8.w,
            children: [
              UserAvatar(userName: user.fullName, profile: user.profilePic, size: 50),
              _buildUserInfo(username, date: review.createdAt, context: context),
              const Spacer(),
              if (review.rate != null) _buildRatingIcon("${review.rate}"),
            ],
          ),
          if(review.comment!=null)
          Text(review.comment!,
              style: TextStyles.bodyMedium),
        ],
      ),
    );
  }
 /// Build user info
  Widget _buildUserInfo(String userName, {DateTime? date, required BuildContext context}) => Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userName,
          style: TextStyles.labelSmall.copyWith(fontWeight: FontWeightHelper.medium),
        ),
        if (date != null)
          Text(
            date.timeAgo,
            style: TextStyles.bodySmall.copyWith(color: context.colors.surfaceContainer),
          ),
      ],
    ),
  );
  /// Build rating icon
  Widget _buildRatingIcon(String rate) => Row(
    spacing: 2.w,
    children: [
      Icon(MvIcons.star, size: 16.sp, color: AppColors.warning),
      Text(rate, style: TextStyles.labelSmall),
    ],
  );
}