import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/widgets/cards/order_cards.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/features/shop/history/logic/order_history_cubit.dart';
import '../../../../core/widgets/scaffold/base_appbar.dart';
import '../../shared/model/order_model.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 70.h,
          child: BaseAppBar(title: "Order History", showLeading: false,),
        ),
        Expanded(
          child: BaseBlocConsumer<OrderHistoryCubit, List<OrderModel>>(
            successBuilder: (orders)=> _buildOrderList(orders),
            loadingBuilder: ()=>_buildOrderList(List<OrderModel>.generate(5, (_)=>OrderModel())),
          ),
        )
      ],
    );
  }

  Widget _buildOrderList(List<OrderModel>orders)=>ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemBuilder: (_,i)=> OrderDetailsCard(order: orders[i])
      ,separatorBuilder: (_,_)=>Gap.medium(),
      itemCount: orders.length) ;
}


