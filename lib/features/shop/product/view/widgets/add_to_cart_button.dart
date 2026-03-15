import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/text_styles.dart';
import '../../../../../../core/widgets/app_button.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  AppButton(
      text: "Add To cart",
      fixedSize: Size(double.infinity, 41.h),
      padding: EdgeInsets.zero,
      style: TextStyles.bodySmall,
      icon: Icon(Icons.shopping_bag, size: 18.sp,),
      buttonSize: null,
    );
  }
}
