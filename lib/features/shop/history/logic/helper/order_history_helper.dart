import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/widgets/message_alert.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../core/widgets/buttons/app_button.dart';
import '../../../../../core/widgets/success_screen.dart';
import '../../../shared/model/order_model.dart';

class OrderHistoryHelper {
    const OrderHistoryHelper._();


    static void onSuccess(BuildContext context, {required OrderModel order, bool isDelete = false}){
      final type = isDelete ? MessagesAlertType.orderDeleted : MessagesAlertType.orderCancelled ;
      final message = "Your order #${order.orderIdDisplay} has been ${isDelete ? "deleted" : "cancelled"} successfully.\nIf you have any questions or need assistance, please contact our support team.";
      final args = ResultScreenArgs(
        type: type,
        customMessage: message,
        action: (c) => Column(
          spacing: 8.h,
          children: [
            AppButton(
              text: "Back to Home",
              buttonSize: null,
              onPressed: () => c.pushNamedAndRemoveUntil(
                Routes.mainLayout,
                predicate: (_) => false,
              ),
            ),
            AppButton.outlined(
              text: "to Orders",
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

}