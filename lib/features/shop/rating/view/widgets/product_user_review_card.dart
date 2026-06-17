import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/date_time.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
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
    final username = user.id == userCubit.user?.id ? AppStrings.you.tr() : user.fullName??AppStrings.unknown.tr();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: context.isDark ? AppColors.grey800 : AppColors.white,
        borderRadius: BorderRadius.circular(Decorations.borderRadius8.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5.h,
        children: [
          Row(
            spacing: 8.w,
            children: [
              UserAvatar(userName: user.fullName, profile: user.profilePic, size: 40),
              _buildUserInfo(username, date: review.createdAt, context: context),
            ],
          ),
          if(review.comment != null)
          Text(review.comment!, style: TextStyles.bodyMedium).paddingVr(8)
          else Row(
            spacing: 4.w,
            children: [
              Icon(MvIcons.info, size: 14.sp, color: context.colors.surfaceContainer),
              Text(AppStrings.noCommentAvailable.tr(), style: TextStyles.bodySmall.copyWith(color: context.colors.surfaceContainer)).paddingVr(8),
            ],
          ),
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
}