import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/widgets/app_button.dart';
import 'package:multi_vendor/core/widgets/scaffold/sticky_bottom_layout.dart';
import 'package:multi_vendor/features/shop/checkout/view/widgets/checkout_total_payments_summery.dart';
import 'package:multi_vendor/features/shop/checkout/view/widgets/select_payment_tile.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/cards/checkout_card.dart';
import '../../../../core/widgets/cards/order_cards.dart';
import '../../../../core/widgets/scaffold/base_appbar.dart';
import '../../../../core/widgets/scaffold/base_scaffold.dart';
import '../../../../core/widgets/section_header.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      paddingHr: 0,
      paddingVr: 0,
      appBar: BaseAppBar(title: "Checkout"),
      body: StickyBottomLayout(
        sticky:  AppButton(
          text: "Place an Order",
          buttonSize: null,
          onPressed: ()=>context.pushNamed(Routes.orderSuccess)
        ),
        content: Column(
          spacing:  16.h,
          children: [
            _buildAddressInfo(),
            _buildShippingDate(),
            _buildProducts(),
            const SelectPaymentTile(),
            const CheckoutTotalPaymentsSummery(),
          ],
        ),
      ),
    );
  }
  Widget _buildAddressInfo()=>const _CheckoutExpansionTile("Shipping Address", OrderAddressInfoCard());
  Widget _buildShippingDate()=>   const _CheckoutExpansionTile("Delivery date",  OrderShippingDateCard()) ;
  Widget _buildProducts()=> const _CheckoutExpansionTile("Ordered Product (6)",    CheckoutProductList(),initiallyExpanded: false);
}
class _CheckoutExpansionTile extends StatelessWidget {
  final String title ;
  final Widget content  ;
  final bool initiallyExpanded;
  const _CheckoutExpansionTile(this.title,this.content, {this.initiallyExpanded=true});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: EdgeInsets.zero,
      tilePadding: EdgeInsets.zero,
      initiallyExpanded: initiallyExpanded,
      title: SectionHeader(title: title),
      children: [content],
    );
  }
}

