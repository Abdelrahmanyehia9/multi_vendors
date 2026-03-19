import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/widgets/app_button.dart';import '../../../../core/utils/feature_flags.dart';
import '../../../../core/widgets/cards/checkout_card.dart';
import '../../../../core/widgets/cards/order_cards.dart';
import '../../../../core/widgets/scaffold/base_appbar.dart';
import '../../../../core/widgets/scaffold/base_scaffold.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BaseScaffold(
      appBar: BaseAppBar(title: "Order Details"),
      body: SingleChildScrollView(
        child:  Column(
          spacing: 16.h,
          children:  [
            const OrderDetailsCard(hasAction: false,title: "Order Details",),
            const OrderAddressInfoCard(hasAction: false, title: "Shipping Address",),
            const CheckoutProductList(showHeader: true,),
            const OrderReceiptCard(hasTitle: true,),
            _buildOrderDetailsAction(),

          ],
        ),
      ),
    );
  }
  Widget _buildOrderDetailsAction()=>Column(
    spacing: 8.h,
    children: [
      const AppButton(text: "Order Again",buttonSize: null,),
      if(FeatureFlags.enableRating)
      AppButton.outlined(text: "Rate order",onPressed: (){},),
    ],
  );
}
