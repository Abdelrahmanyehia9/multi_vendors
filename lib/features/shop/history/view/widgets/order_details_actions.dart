import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/enum/order_status.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/features/shop/shared/model/order_model.dart';

class OrderDetailsActions extends StatelessWidget {
  final OrderModel order ;
  const OrderDetailsActions({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final hasUnratedItems = order.items?.any((item) => item.isRated == false)??false;
    final status = order.status;
    return Column(
      spacing: 8.h,
      children: [
        if(status == OrderStatus.delivered)...[
          if(FeatureFlags.enableRating && hasUnratedItems)
            AppButton.outlined(text: AppStrings.rateOrder.tr(),onPressed:order.items.isNullOrEmpty? null: ()=>context.pushNamed(Routes.rateOrder, arguments: order.items),),
        ],
        if(status == OrderStatus.pending ||order.trackId!=null)
        AppButton(text: AppStrings.orderTracking.tr(),buttonSize: null, onPressed: () {
          context.pushNamed(Routes.orderTracking, arguments: order.trackId);
        }),
      ],
    );
  }
}