import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';

import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/shared/view/widgets/message_alert.dart';
import 'package:multi_vendor/shared/view/success_screen.dart';
import 'package:multi_vendor/features/shop/shared/model/order_model.dart';




class OrderHistoryHelper {
    const OrderHistoryHelper._();
    static void onOrderActionSuccess(BuildContext context, {required OrderModel order, bool isDelete = false}){
      final type = isDelete ? MessagesAlertType.orderDeleted : MessagesAlertType.orderCancelled ;
      final args = ResultScreenArgs(
        type: type,
        action: (c) => Column(
          spacing: 8.h,
          children: [
            AppButton(
              text: AppStrings.backToHome.tr(),
              buttonSize: null,
              onPressed: () => c.pushNamedAndRemoveUntil(
                Routes.mainLayout,
                predicate: (_) => false,
              ),
            ),
            AppButton.outlined(
              text: AppStrings.toOrders.tr(),
              onPressed: () => c.pushNamedAndRemoveUntil(
                Routes.mainLayout,
                predicate: (_) => false,
                arguments: 3,
              ),
            ),
          ],
        ),
      );
      context.pushNamedAndRemoveUntil(
        Routes.result,
        predicate: (_) => false,
        arguments: args,
      );
    }
    static void onRatingSuccess(BuildContext context){
      final args = ResultScreenArgs(
        type: MessagesAlertType.reviewSubmitted,
        action: (c) => Column(
          spacing: 8.h,
          children: [
            AppButton(
              text: AppStrings.backToHome.tr(),
              buttonSize: null,
              onPressed: () => c.pushNamedAndRemoveUntil(
                Routes.mainLayout,
                predicate: (_) => false,
              ),
            ),
            AppButton.outlined(
              text: AppStrings.back.tr(),
              onPressed: () => c.pop(),
            ),
          ],
        ),
      );
      context.pushNamed(
        Routes.result,
        arguments: args,
      );

    }
}