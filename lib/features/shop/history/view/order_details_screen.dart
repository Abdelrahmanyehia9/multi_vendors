import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/features/shop/history/view/widgets/order_details_actions.dart';
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
          children:  const [
            OrderDetailsCard(hasAction: false,title: "Order Details",),
            OrderAddressInfoCard(hasAction: false, title: "Shipping Address",),
            CheckoutProductList(showHeader: true,),
            // OrderReceiptCard(hasTitle: true,),
            OrderDetailsActions(),
          ],
        ),
      ),
    );
  }
}



