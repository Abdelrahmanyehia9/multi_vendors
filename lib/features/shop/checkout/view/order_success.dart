import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/core/widgets/scaffold/sticky_bottom_layout.dart';
import 'package:multi_vendor/features/shop/shared/model/checkout_model.dart';
import 'package:multi_vendor/features/shop/shared/widgets/checkout_list_porducts.dart';
import 'package:multi_vendor/shared/view/widgets/cards/order_cards.dart';
import 'package:multi_vendor/shared/view/widgets/message_alert.dart';
import 'package:multi_vendor/features/shop/shared/model/order_model.dart';
import 'package:multi_vendor/features/shop/shared/widgets/order_address_info_card.dart';
import 'package:multi_vendor/features/shop/shared/widgets/order_recipt_card.dart';

class OrderSuccessScreen extends StatelessWidget {
  final OrderModel order;
  const OrderSuccessScreen({super.key ,required this.order});

  @override
  Widget build(BuildContext context) {
    final String successMsg = "${AppStrings.weAreHappyToInformYouThatYourOrder.tr()} ${order.orderIdDisplay} ${AppStrings.hasBeenCompleted.tr()}. ${AppStrings.thankYouForYourTrustInShoppingAtOurStore.tr()}" ;
    return  BaseScaffold(
      paddingHr: 0,
      body: StickyBottomLayout(
          content: _buildContent(context, successMsg: successMsg),
          sticky: _buildSticky(context))
    );
  }
  Widget _buildContent(BuildContext context, {required String successMsg})=>SingleChildScrollView(
    child:  Column(
      spacing: 16.h,
      children:  [
        MessageAlert(MessagesAlertType.orderSuccess , customMessage: successMsg),
        OrderDetailsCard(
          order: order,
          hasStatus: false, hasAction: false,title: AppStrings.orderDetails.tr(),),
        if(order.address != null)
          OrderAddressInfoCard(hasAction: false, title: AppStrings.shippingAddress.tr(),address: order.address!,) ,
        CheckoutListProducts(showHeader: true, items: order.items??[],),
        OrderReceiptCard(hasTitle: true,summery: order.summery ?? CheckoutSummeryModel.fake()),

      ],
    ),
  ) ;
  Widget _buildSticky(BuildContext context)=>AppButton(text: AppStrings.backToHome.tr(), buttonSize: null,
    onPressed: ()=> context.pushNamedAndRemoveUntil(Routes.mainLayout, predicate: (_)=>false),
  ) ;
}




