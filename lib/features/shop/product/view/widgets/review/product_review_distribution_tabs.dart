import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/shared/data/models/rating_model.dart';
import 'package:multi_vendor/shared/view/widgets/app_chip.dart';

class ProductReviewDistributionTabs extends StatelessWidget {
  final RatingDistribution distribution;

  final ValueNotifier<int?> selected;

  const ProductReviewDistributionTabs({
    super.key,
    required this.selected,
    required this.distribution,
  });

  @override
  Widget build(BuildContext context) {
    final List<int> distributionList = [
      distribution.one,
      distribution.two,
      distribution.three,
      distribution.four,
      distribution.five,
    ];
    return ValueListenableBuilder(
      valueListenable: selected,
      builder: (context, value, child) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            spacing: 8.w,
            children: [
              _chip(
                  context: context,
                  "All", selected: value == null, onTap: (){
                selected.value = null;
              }),
              ...List.generate(
                distributionList.length,
                (i) => _chip(
                  context: context,
                    onTap: (){
                      selected.value = 5 - i;
                    },
                    "${5 - i}", selected: value == (5 - i)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _chip(
    String text, {
    IconData icon = MvIcons.star,
    required bool selected,
    required GestureTapCallback onTap,
    required BuildContext context,
  }) {
    final Color selectedColor = AppColors.primary;
    return AppClick(
    onTap: onTap,
    child: AppChip(
      selectedColor: selectedColor,
      selectedBorderColor: selectedColor,
      unSelectedBorderColor: selectedColor,
      text: text,
      selected: selected,
      child: Row(
        spacing: 4.w,
        children: [
          Icon(
            icon,
            size: 18.sp,
            color: selected ? AppColors.white : selectedColor,
          ),
          Text(
            text,
            style: TextStyles.bodySmall.copyWith(
              color: selected ? AppColors.white :selectedColor,
            ),
          ),
        ],
      ),
    ),
  );
  }
}
