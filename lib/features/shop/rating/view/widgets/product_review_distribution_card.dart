import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/shared/data/models/rating_model.dart';
import 'package:multi_vendor/shared/view/widgets/rating_stars.dart';

class ProductReviewDistributionCard extends StatelessWidget {
  final RatingModel? rating ;
  const ProductReviewDistributionCard({super.key,  this.rating});

  @override
  Widget build(BuildContext context) {
    final List<int>distribution = [rating?.distribution?.one ?? 0, rating?.distribution?.two ?? 0, rating?.distribution?.three ?? 0, rating?.distribution?.four ?? 0, rating?.distribution?.five ?? 0];
    final List<String> distributionsString = [AppStrings.poorRate, AppStrings.averageRate, AppStrings.goodRate, AppStrings.veryGoodRate, AppStrings.excellentRate] ;
    final int count = rating?.count ?? 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            children: [
              Text(
                (rating?.rating??0).toString(),
                style: TextStyles.headline2.copyWith(
                    fontWeight: FontWeightHelper.bold
                ),
              ),
               RatingStars(
                showCount: false,
                size: 20,
                rating: rating,
              ),
               Text(
                '${rating?.count??0} ${AppStrings.reviews.tr()}',
                textAlign: TextAlign.center,
                style: TextStyles.bodySmall.copyWith(
                  color: context.colors.surfaceContainer,
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 2,
          child: Column(
            children: List.generate(

              5, (i) {
                final double  percentage= distribution[i] / (count==0?1:count) ;
                return Row(
                spacing: 4.w,
                children: [
                  Text(
                    distributionsString[i].tr(),
                    style: TextStyles.bodyMedium.copyWith(
                        fontSize: 14.sp,
                      color: context.colors.surfaceContainerHigh,
                      ),
                  ),
                  Expanded(
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(Decorations.borderRadius4.r),
                      minHeight: 6.h,
                      color: AppColors.warning,
                      value: percentage,
                      backgroundColor: context.colors.surfaceContainerLowest,
                    ),
                  ),
                  Text("${(percentage * 100).toStringAsFixed(0)}%", style: TextStyles.captionSmall.copyWith(color: context.colors.surfaceContainer))
                ],
              ).paddingVr(2);
              },
            ),
          ),
        ),
      ],
    );
  }
}
