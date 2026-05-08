import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/features/shop/cart/data/models/promo_code_model.dart';
import 'package:multi_vendor/features/shop/shared/model/checkout_model.dart';
import 'package:multi_vendor/features/shop/shared/widgets/order_recipt_card.dart';
import 'package:multi_vendor/shared/view/widgets/section_header.dart';

class CheckoutTotalPaymentsSummery extends StatelessWidget {
  final CheckoutSummeryModel summery;
  final CouponInfo? coupon ;
  const CheckoutTotalPaymentsSummery({super.key, required this.summery, this.coupon});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
         SectionHeader(title: AppStrings.totalPayment.tr(),),
         OrderReceiptCard(summery: summery, coupon: coupon),
      ],
    );
  }
}
