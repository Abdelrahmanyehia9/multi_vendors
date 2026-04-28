import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/date_time.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/features/shop/shared/model/order_model.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/shared/view/widgets/section_header.dart';
import 'package:multi_vendor/shared/view/widgets/cards/info_box.dart';

class OrderDetailsCard extends StatelessWidget {
  final bool hasStatus;
  final bool hasAction;
  final String? title;
final OrderModel order;
  const OrderDetailsCard({
    super.key,
    this.hasStatus = true,
    this.hasAction = true,
    this.title,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return InfoBox(
      title: title == null ? null : SectionHeader(title: title!),
      header: hasStatus && order.status != null ? _buildHeader() : null,
      items: [
        ("Order Number", order.orderIdDisplay),
        ("Purchase date", order.createdAt?.formattedDate),
        ("Payment", "${order.payment?.option.title??""} (${order.payment?.status.title??""})"),
        ("Estimated Delivery", order.estimatedDelivery?.formattedDate),
      ],
      bottom: hasAction
          ? AppButton(
              text: "Details",
              buttonSize: null,
              onPressed: () {
                if(order.id == null) return;
                context.pushNamed(Routes.orderDetails, arguments: order.id!);
              },
            )
          : null,
    );
  }

  Widget _buildHeader() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text("Order Status", style: TextStyles.captionMedium),
      Text(
        order.status!.title,
        style: TextStyles.labelSmall.copyWith(color: order.status?.color),
      ),
    ],
  );
}

