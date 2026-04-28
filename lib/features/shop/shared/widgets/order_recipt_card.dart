import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
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
        if (hasTitle) const SectionHeader(title: "Total Payment"),
        _buildPriceRow(("Subtotal", summery.subTotalDisplay), context),
        if (summery.discountDisplay!=null)
          _buildPriceRow(
            (promo?.code??"Discount", summery.discountDisplay),
            context,
            titleColor: AppColors.success,
          ),

        if (shipping != null)
          _buildPriceRow(
            ("Shipping", shipping, ),
            context,

          ),

        if (summery.taxDisplay != null)
          _buildPriceRow(("TAX", summery.taxDisplay), context),

        Divider(height: 20.h),

        _buildPriceRow(
          ("Total", summery.totalDisplay),
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