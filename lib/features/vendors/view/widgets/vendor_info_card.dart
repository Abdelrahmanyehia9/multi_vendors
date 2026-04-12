import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/features/vendors/data/model/vendor_details_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/decorations.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/app_chip.dart';
import '../../../../core/widgets/gap.dart';

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
                  padding: EdgeInsets.zero,
                  text: e,
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
                  Icons.star_rounded,
                  AppColors.warning,
                  '${rating.rating} (${rating.count})',
                  'Rating',
                  showDivider: delivery != null,
                ),
              if (delivery != null) ...[
                _stat(
                  Icons.delivery_dining_rounded,
                  AppColors.secondaryDark,
                  '${delivery.estimatedDeliveryTime.min}-${delivery.estimatedDeliveryTime.max} Min',
                  'Delivery Time',
                  showDivider: delivery.deliveryFees != null,
                ),
                if (delivery.deliveryFees != null)
                  _stat(
                    Icons.local_shipping_outlined,
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