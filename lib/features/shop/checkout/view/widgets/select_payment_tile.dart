import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/enum/payment_option.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/text_styles.dart';



class CheckoutPaymentOptionsList extends StatelessWidget {
  final ValueNotifier<PaymentOption?>selectedOption ;
  const CheckoutPaymentOptionsList({super.key, required this.selectedOption});

  @override
  Widget build(BuildContext context) {
    final items = AppConstants.payments ;
    return ValueListenableBuilder(
      valueListenable: selectedOption,
      builder: (context, value, child) {
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_,_) => Gap.small(),
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (_,i)=>_SelectPaymentTile(
              option: items[i],
              isSelected: value == items[i],
              onTap: ()=>selectedOption.value = items[i],
            )
        );
      }
    );
  }
}






class _SelectPaymentTile extends StatelessWidget {
  final PaymentOption option ;
  final bool isSelected ;
  final GestureTapCallback? onTap ;
  const _SelectPaymentTile({this.onTap ,required this.option, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AppClick(
      onTap: onTap,
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        width: double.infinity,
        height: 50.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Decorations.borderRadius8.r),
          border:  Border.all(color: isSelected?AppColors.primary : context.colors.surfaceContainerLowest , width: 1.2) ,
          color: isSelected ?  AppColors.primary.veryLight : null,
        ),
        child:  Row(
          spacing: 8.w,
          children: [
            Icon(option.icon,size: 20.sp , color: isSelected?  AppColors.primary : context.colors.surfaceContainer),
            Text(option.title, style: TextStyles.labelMedium.copyWith(
              color: isSelected?  AppColors.primary : context.colors.surfaceContainer
            )),
            const Spacer(),
            if(isSelected)
             Icon(Icons.check_circle,size: 24.sp, color: AppColors.primary),
          ],
        ).appPaddingHr,
      ),
    );
  }
}
