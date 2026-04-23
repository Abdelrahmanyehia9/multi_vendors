import 'package:flutter/material.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/buttons/app_icon_button.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/core/widgets/scaffold/sticky_bottom_layout.dart';
import 'package:multi_vendor/features/shop/history/view/widgets/order_captain_card.dart';
import 'package:multi_vendor/features/shop/history/view/widgets/order_tracking_timeline.dart';
import '../../../../core/enum/order_status.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      paddingHr: 0,
      appBar: BaseAppBar(
          title: "Order Tracking", 
          actions: const [
            AppIconButton(icon: Icons.refresh)
          ],
      
      ),
      body: const StickyBottomLayout(
        content: SingleChildScrollView(
          child: Column(
            spacing: 16,
            children: [
              OrderTrackingTimeLine(status: TrackStatus.shipped),
              OrderCaptainCard(),
            ],
          ),
        ),
        sticky: AppButton(
          text: "Cancel order",
          buttonSize: null,
        ),
      ),
    );
  }
}
