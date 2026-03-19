import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import '../../../../core/widgets/cards/order_cards.dart';
import '../../../../core/widgets/scaffold/base_appbar.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 70.h,
          child: BaseAppBar(title: "Order History"),
        ),
        Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemBuilder: (_,index)=>const OrderDetailsCard()
            , separatorBuilder: (_,_)=>Gap.medium(),
            itemCount: 2))
      ],
    );
  }
}


