import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/helper/clipboard_helper.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/features/main/home/logic/home_on_going_order_cubit.dart';
import 'package:multi_vendor/features/shop/shared/model/order_model.dart';
import 'package:multi_vendor/shared/view/widgets/app_slider.dart';

class HomeOnGoingOrder extends StatelessWidget {
  final Color color;

  const HomeOnGoingOrder({super.key, this.color = AppColors.secondary});

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<HomeOnGoingOrderCubit, List<OrderModel>>(
      successBuilder:(orders)=> AppSlider(
        height: 120,
        slides: orders.map((order) => _Slide(color, order)).toList(),
      ),
    ) ;
  }

}


class _Slide extends StatelessWidget {
  final Color color;
  final OrderModel order;
  const _Slide(this.color, this.order);

  @override
  Widget build(BuildContext context) {
    final Color textColor = AppColors.white;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w,),
      width: double.infinity,
      color: AppColors.secondary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              spacing: 4.h,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.youHavePendingOrder.tr(),
                  style: TextStyles.captionSmall.copyWith(
                    color: color,
                    backgroundColor: textColor,
                  ),
                ),

                    Text(
                      AppStrings.orderNumber.tr(),
                      style: TextStyles.bodySmall.copyWith(color: textColor),
                    ),
                _orderNumber(textColor, context: context, oNumber: order.orderIdDisplay),

              ],
            ),
          ),
          _trackOrderButton(textColor, order, context: context),
        ],
      ),
    );
  }

  Widget _orderNumber(Color textColor, {required BuildContext context,required String oNumber}) =>
      AppClick(
        onTap: () =>
            ClipboardHelper.instance.copyToClipboard(
          oNumber, context: context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4.w,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 120.w,

              ),
              child: Text(
                maxLines: 2,
                oNumber,
                style: TextStyles.labelSmall.copyWith(
                  color: textColor,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.white,
                  decorationThickness: 1.sp,
                ),
              ),
            ),
            Icon(Icons.copy, color: textColor, size: 14.sp)
          ],
        ),
      );
  Widget _trackOrderButton(Color textColor, OrderModel order, {required BuildContext context}) =>
      Column(
        spacing: 4.h,
        mainAxisSize: MainAxisSize.min,
        children: [
          if(order.trackId != null)
          AppButton(
            onPressed: ()=>context.pushNamed(Routes.orderTracking,arguments: order.trackId),
            text: AppStrings.orderTracking.tr(),
            buttonSize: null,
            fixedSize: Size(128.w, 32.h),
            color: textColor,
            padding: EdgeInsets.zero,
            style: TextStyles.labelSmall,
            textColor: color,
          ),
          AppButton.outlined(
            onPressed: ()=>context.pushNamed(Routes.orderDetails,arguments: order.id),
            text: AppStrings.more.tr(),
            fixedSize: Size(128.w, 32.h),
            color: textColor,
            style: TextStyles.labelSmall,
          ),
        ],
      );
}
