import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/context.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/decorations.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/app_chip.dart';
import '../../../../core/widgets/gap.dart';

class VendorInfoCard extends StatelessWidget {
  const VendorInfoCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.sp),
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: context.scaffoldBackground,
        borderRadius: BorderRadius.circular(Decorations.borderRadius16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAppOpacity(.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 4.sp,
            children: List.generate(4, (index) => const AppChip(
                padding: EdgeInsets.zero,
                text: "Men Clothes", selected: true)),
          ),
          Gap.medium(),
          Row(
            children: [
              _stat(Icons.star_rounded, AppColors.warning, '4.6 (124)', 'Rating'),
              _divider(),
              _stat(Icons.delivery_dining_rounded, AppColors.secondaryDark,
                  '20-50 Min', 'Delivery Time'),
              _divider(),
              _stat(Icons.local_shipping_outlined, AppColors.success,
                  '25 EGP', 'Delivery Fees'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _divider() => Container(
    width: 1.w,
    height: 40.h,
    color: AppColors.grey.withAppOpacity(.3),
  );
  Widget _stat(IconData icon, Color color, String label, String sub) =>
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 25.sp),
            const SizedBox(height: 4),
            Text(label, textAlign: TextAlign.center, style: TextStyles.labelSmall),
            Text(sub, style: TextStyles.captionSmall),

          ],
        ),
      );
}