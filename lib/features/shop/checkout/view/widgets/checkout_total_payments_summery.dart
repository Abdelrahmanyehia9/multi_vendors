import 'package:flutter/material.dart';
import 'package:multi_vendor/core/widgets/section_header.dart';
import 'package:multi_vendor/features/shop/cart/data/models/promo_code_model.dart';
import 'package:multi_vendor/features/shop/shared/model/checkout_model.dart';
import 'package:multi_vendor/features/shop/shared/widgets/order_recipt_card.dart';

class CheckoutTotalPaymentsSummery extends StatelessWidget {
  final CheckoutSummeryModel summery;
  final CouponInfo? coupon ;
  const CheckoutTotalPaymentsSummery({super.key, required this.summery, this.coupon});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const SectionHeader(title: "Total Payment",),
         OrderReceiptCard(summery: summery, coupon: coupon),
      ],
    );
  }
}
