import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/date_time.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/shared/view/widgets/user_avatar.dart';

class ProductUserReviewCard extends StatelessWidget {
  const ProductUserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h
      ),
      decoration: BoxDecoration(
        color:context.isDark ? AppColors.grey800 : AppColors.white,
        borderRadius: BorderRadius.circular(Decorations.borderRadius8.w),
      ),
      child: Column(
        spacing: 5.h,
        children: [
          Row(
            spacing: 8.w,
            children: [
              const UserAvatar(userName: "mazen", size: 50,),
              _buildUserInfo("Mazen Ahmed", date: DateTime.now(), context: context),
              const Spacer(),
             _buildRatingIcon("4.5"),
            ],
          ),

          Text("this item is very nice i liked it so much " , style: TextStyles.bodyMedium,)
        ],
      ),

    );
  }
  Widget _buildUserInfo(String userName ,{DateTime? date, required BuildContext context})=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(userName, style: TextStyles.labelSmall.copyWith(
        fontWeight: FontWeightHelper.medium
      ),),
      if(date != null)
      Text(date.timeAgo, style: TextStyles.bodySmall.copyWith(
          color: context.colors.surfaceContainer
      ),)
    ],
  ) ;
  Widget _buildRatingIcon(String rate)=>Row(
    spacing: 2.w,
    children: [
      Icon(MvIcons.star, size: 16.sp, color: AppColors.warning),
       Text(rate, style: TextStyles.labelSmall,),
    ],
  ) ;
}
