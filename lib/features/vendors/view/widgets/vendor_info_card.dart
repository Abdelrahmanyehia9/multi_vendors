import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/features/shop/rating/view/reviews_screen.dart';
import 'package:multi_vendor/features/vendors/data/model/vendor_details_model.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/shared/view/widgets/app_chip.dart';

class VendorInfoCard extends StatelessWidget {
  final VendorDetailsModel vendor;
  const VendorInfoCard({super.key, required this.vendor});

  @override
  Widget build(BuildContext context) {
    final rating = vendor.vendorRating;
    final delivery = vendor.deliveryOption;
    final tags = vendor.categories;
    if (!vendor.hasInfo) return const SizedBox.shrink();
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
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (tags != null)
            Wrap(
              spacing: 4.sp,
              children: tags
                  .map(
                    (e) => AppChip(
                  padding: EdgeInsets.all(4.w),
                  textStyle: TextStyles.bodySmall.copyWith(color: AppColors.white),
                  text: e.name,
                  selected: true,
                ),
              )
                  .toList(),
            ),
          Gap.medium(),
          Row(
            children: [
              if (rating != null)

                _stat(
                  MvIcons.star,
                  AppColors.warning,
                  '${rating.rating} (${rating.count})',
                  'Rating',
                  showDivider: delivery != null,
                ),
              if (delivery != null) ...[
                _stat(
                  MvIcons.delivery,
                  AppColors.secondaryDark,
                  '${delivery.estimatedDeliveryTime.min}-${delivery.estimatedDeliveryTime.max} Min',
                  'Delivery Time',
                  showDivider: delivery.deliveryFees != null,
                ),
                if (delivery.deliveryFees != null)
                  _stat(
                    MvIcons.shipping,
                    AppColors.success,
                    delivery.deliveryFees!.usdPrice,
                    'Delivery Fees',
                    showDivider: false,
                  ),
              ],
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

  Widget _stat(
      IconData icon,
      Color color,
      String value,
      String label, {
        required bool showDivider,
      }) =>
      Expanded(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: color, size: 25.sp),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    textAlign: TextAlign.center,
                    style: TextStyles.labelSmall,
                  ),
                  Text(label, style: TextStyles.captionSmall),
                ],
              ),
            ),
            if (showDivider) _divider(),
          ],
        ),
      );
}