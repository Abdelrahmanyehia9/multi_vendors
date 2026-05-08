import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/date_time.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
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
        (AppStrings.orderNumber.tr(), order.orderIdDisplay),
        (AppStrings.purchaseDate.tr(), order.createdAt?.formattedDate),
        (AppStrings.payment.tr(), "${order.payment?.option.title??""} (${order.payment?.status.title??""})"),
        (AppStrings.estimatedDelivery.tr(), order.estimatedDelivery?.formattedDate),
      ],
      bottom: hasAction
          ? AppButton(
              text: AppStrings.details.tr(),
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
      Text(AppStrings.orderStatus.tr(), style: TextStyles.captionMedium),
      Text(
        order.status!.title,
        style: TextStyles.labelSmall.copyWith(color: order.status?.color),
      ),
    ],
  );
}

