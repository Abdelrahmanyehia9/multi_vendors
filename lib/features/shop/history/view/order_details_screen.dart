import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/features/shop/history/view/widgets/order_details_actions.dart';
import 'package:multi_vendor/features/shop/shared/widgets/checkout_list_porducts.dart';
import '../../../../core/widgets/cards/order_cards.dart';
import '../../../../core/widgets/scaffold/base_appbar.dart';
import '../../../../core/widgets/scaffold/base_scaffold.dart';
import '../../shared/model/order_model.dart';
import '../../shared/widgets/order_address_info_card.dart';
import '../../shared/widgets/order_recipt_card.dart';
import '../logic/order_details_cubit.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BaseScaffold(
      appBar: BaseAppBar(title: "Order Details"),
      body: BaseBlocConsumer<OrderDetailsCubit, OrderModel>(
        successBuilder:(order)=> _buildOrderDetails(order),
        loadingBuilder: ()=>_buildOrderDetails(OrderModel.fake()),
      ),
    );
  }

  Widget _buildOrderDetails(OrderModel order)=>SingleChildScrollView(
    child:  Column(
      spacing: 16.h,
      children:   [
         OrderDetailsCard(hasAction: false,title: "Order Details", order: order),
         if(order.address != null)
         OrderAddressInfoCard(hasAction: false, title: "Shipping Address", address: order.address!),
         CheckoutListProducts(showHeader: true, items: order.items!),
         OrderReceiptCard(hasTitle: true,summery: order.summery!),
        OrderDetailsActions(order: order),
      ],
    ),
  );
}



