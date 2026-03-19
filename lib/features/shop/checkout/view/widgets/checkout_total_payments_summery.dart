import 'package:flutter/material.dart';
import 'package:multi_vendor/core/widgets/section_header.dart';
import '../../../../../core/widgets/cards/order_cards.dart';

class CheckoutTotalPaymentsSummery extends StatelessWidget {
  const CheckoutTotalPaymentsSummery({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SectionHeader(title: "Total Payment",),
        OrderReceiptCard(),
      ],
    );
  }
}
