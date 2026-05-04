import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/types/type_def.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/shared/view/widgets/app_slider.dart';

class OnboardingItem extends StatelessWidget {
  final OnBoardingItemData item;
  final int currentIndex;
  final int total;

  const OnboardingItem({
    super.key,
    required this.item,
    required this.currentIndex,
    required this.total,

  });

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    return Column(
      spacing: 12.h,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Decorations.borderRadius16.r),
          child: Image.asset(
            item.imagePath,
            fit: BoxFit.cover,
            height: height * .42,
            width: double.infinity,
          ),
        ),
        /// dots
        SliderDots(
          total: total,
          currentIndex: currentIndex,
        ),
        Gap.small(),
        /// title
        _buildTitle(item),
        /// description
        Text(
          item.description,
          style: TextStyles.captionMedium.copyWith(
            color: context.colors.surfaceContainer
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ).appPaddingHr;
  }

  Widget _buildTitle(OnBoardingItemData item) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: item.title,
          ),
          if (item.titleHighlighter != null)
            TextSpan(
              text: " ${item.titleHighlighter!}",
              style: TextStyles.labelLarge.copyWith(
                color: AppColors.primary,
              ),
            ),
        ],
        style: TextStyles.labelLarge
      ),
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}