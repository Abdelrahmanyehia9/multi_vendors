import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/features/shop/cart/data/models/promo_code_model.dart';
import 'package:multi_vendor/features/shop/shared/model/extension/checkout_summery_model_extension.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/types/type_def.dart';
import 'package:multi_vendor/shared/view/widgets/section_header.dart';
import 'package:multi_vendor/features/shop/shared/model/checkout_model.dart';

class OrderReceiptCard extends StatelessWidget {
  final bool hasTitle;
  final CheckoutSummeryModel summery;
  final CouponInfo? coupon ;
  const OrderReceiptCard({
    super.key,
    this.hasTitle = false,
    this.coupon,
    required this.summery,
  });

  @override
  Widget build(BuildContext context) {
    final promo = coupon;
    final String? shipping = summery.shippingDisplay(promo);
    return Column(
      spacing: 2.h,
      children: [
        if (hasTitle)  SectionHeader(title: AppStrings.totalPayment.tr()),
        _buildPriceRow((AppStrings.subtotal.tr(), summery.subTotalDisplay, child: null), context),
        if (summery.discountDisplay!=null)
          _buildPriceRow(
            (promo?.code??AppStrings.discount.tr(), summery.discountDisplay, child: null),
            context,
            titleColor: AppColors.success,
          ),

        if (shipping != null)
          _buildPriceRow(
            (AppStrings.shipping.tr(), shipping,child:  null),
            context,

          ),

        if (summery.taxDisplay != null)
          _buildPriceRow((AppStrings.tax.tr(), summery.taxDisplay, child: null), context),

        Divider(height: 20.h),

        _buildPriceRow(
          (AppStrings.total.tr(), summery.totalDisplay , child: null),
          context,
          priceColor: AppColors.primary,
          titleColor: context.colors.surfaceContainerHighest,
        ),
      ],
    );
  }

  Widget _buildPriceRow(
      TitleAndSubtitle item,
      BuildContext context, {
        Color? priceColor,
        Color? titleColor,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          item.$1,
          style: TextStyles.bodyMedium.copyWith(
            color: titleColor ?? context.colors.surfaceContainer,
          ),
        ),
        Text(
          item.$2??"",
          style: TextStyles.labelMedium.copyWith(color: priceColor),
        ),
      ],
    );
  }
}