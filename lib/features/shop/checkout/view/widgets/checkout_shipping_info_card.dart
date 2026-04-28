import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/date_time.dart';

import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/shared/view/widgets/cards/info_box.dart';
import 'package:multi_vendor/shared/view/widgets/section_header.dart';

class OrderShippingInfoCard extends StatelessWidget {
  final bool hasAction;
  final String? title;
  final String shipping  ;
  final DateTime estimatedDelivery ;
  const OrderShippingInfoCard({super.key, required this.estimatedDelivery, required this.shipping ,this.hasAction = true, this.title});

  @override
  Widget build(BuildContext context) {
    return InfoBox(
      title: title == null ? null : SectionHeader(title: title!),
      items:  [
        ("Shipping Costs", shipping),
        ("Estimated Delivery", estimatedDelivery.formattedDate),

      ],
      bottom: hasAction
          ? Text(
        "*Please double check the delivery address details before placing your order",
        style: TextStyles.bodySmall.copyWith(color: AppColors.primary),
      )
          : null,
    );
  }
}
