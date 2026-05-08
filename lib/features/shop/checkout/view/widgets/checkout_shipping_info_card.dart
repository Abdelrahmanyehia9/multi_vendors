import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/date_time.dart';

import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
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
        (AppStrings.shippingCosts.tr(), shipping),
        (AppStrings.estimatedDelivery.tr(), estimatedDelivery.formattedDate),

      ],
      bottom: hasAction
          ? Text(
        "*${AppStrings.pleaseDoubleCheckTheDeliveryAddressDetailsBeforePlacingYourOrder.tr()}",
        style: TextStyles.bodySmall.copyWith(color: AppColors.primary),
      )
          : null,
    );
  }
}
