import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';

class VerifiedChip extends StatelessWidget {
  final double size;

  final String? title;

  const VerifiedChip({super.key, this.title, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: (size*.32).w, vertical: (size*.1).h),
      decoration: BoxDecoration(
        color: AppColors.success.veryLight,
        borderRadius: BorderRadius.circular(Decorations.borderRadius8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: (size*.14).w,
        children: [
          Icon(MvIcons.verified, size: size.sp, color: AppColors.success),
          Text(
            title ?? AppStrings.verified.tr(),
            style: TextStyles.labelMedium.copyWith(
              color: AppColors.success500,
              fontSize: (size * .65).sp,
            ),
          ),
        ],
      ),
    );
  }
}
