import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';

class AppLoaderIndicator extends StatelessWidget {
  final double? value ;
  const AppLoaderIndicator({super.key, this.value});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
        backgroundColor: AppColors.white,
        strokeWidth: 2.sp,
        value: value,
      ),
    );
  }
}
