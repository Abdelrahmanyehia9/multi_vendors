import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/date_time.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/widgets/cards/info_box.dart';
import '../../../../../core/widgets/section_header.dart';

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
