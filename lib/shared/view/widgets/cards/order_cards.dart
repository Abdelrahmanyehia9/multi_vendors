import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/date_time.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
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
  final bool showOrderItems;

  const OrderDetailsCard({
    super.key,
    this.hasStatus = true,
    this.hasAction = true,
    this.title,
    this.showOrderItems = true,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return InfoBox(
      title: title == null ? null : SectionHeader(title: title!),
      header: hasStatus && order.status != null ? _buildHeader() : null,
      items: [
        (AppStrings.orderNumber.tr(), order.orderIdDisplay, child: null),
        (AppStrings.purchaseDate.tr(), order.createdAt
            ?.formattedDate, child: null),
        if(showOrderItems)
        (AppStrings.orderItems.tr(), null, child: _buildOrderItems(order) ),
        (AppStrings.payment.tr(), "${order.payment?.option.title ?? ""} (${order
            .payment?.status.title ?? ""})", child: null),
        (AppStrings.estimatedDelivery.tr(), order.estimatedDelivery
            ?.formattedDate, child: null),
      ],
      bottom: hasAction
          ? AppButton(
        text: AppStrings.details.tr(),
        buttonSize: null,
        onPressed: () {
          if (order.id == null) return;
          context.pushNamed(Routes.orderDetails, arguments: order.id!);
        },
      )
          : null,
    );
  }

  Widget _buildHeader() =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(AppStrings.orderStatus.tr(), style: TextStyles.captionMedium),
          Text(
            order.status!.title,
            style: TextStyles.labelSmall.copyWith(color: order.status?.color),
          ),
        ],
      );

  Widget _buildOrderItems(OrderModel order, {double size = 40}) {
    final items = order.items ?? [];
    const int maxDisplay = 3;
    final displayItems = items.take(maxDisplay).toList();
    final remainderCount = items.length - maxDisplay;
    return Wrap(
      spacing: 4,
      children: [
        ...displayItems.map((item) =>
            Stack(
              children: [
                AppCachedNetworkImage(
                  width: size,
                  height: size,
                  radius: Decorations.borderRadius8,
                  item.product.thumbnail,
                ),
                if(item.quantity > 1)
                CircleAvatar(
                  radius: (size*.25).r,
                  backgroundColor: AppColors.secondary,
                  child: Text((item.quantity-1).toString(), style: TextStyles.labelSmall.copyWith(color: AppColors.white, fontSize: (size*.25).sp, fontWeight: FontWeightHelper.bold)),
                )
              ],
            ),
        ),
        if (remainderCount > 0)
          Container(
            width: size.w,
            height: size.h,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(Decorations.borderRadius8),
            ),
            alignment: Alignment.center,
            child: Text(
              '+$remainderCount',
              style: TextStyles.bodyMedium.copyWith(
                color: AppColors.white
              )
            ),
          ),
      ],
    );
  }}

