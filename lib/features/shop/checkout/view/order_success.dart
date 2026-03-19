import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/widgets/app_button.dart';
import 'package:multi_vendor/core/widgets/cards/checkout_card.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import '../../../../core/widgets/cards/order_cards.dart';
import '../../../../core/widgets/message_alert.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BaseScaffold(
      body: SingleChildScrollView(
        child:  Column(
          spacing: 16.h,
          children:  [
          const MessageAlert(MessagesAlertType.orderSuccess),
          const OrderDetailsCard(hasStatus: false, hasAction: false,title: "Order Details",),
          const OrderAddressInfoCard(hasAction: false, title: "Shipping Address",),
          const CheckoutProductList(showHeader: true,),
          const OrderReceiptCard(hasTitle: true,),
          AppButton(text: "Back to home", buttonSize: null,
          onPressed: ()=> context.popUntil(),

          )
          ],
        ),
      ),
    );
  }
}




