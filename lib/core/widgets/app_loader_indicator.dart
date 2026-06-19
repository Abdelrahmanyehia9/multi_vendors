import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';

class AppLoaderIndicator extends StatelessWidget {
  final double? value ;
  final double size ;
  const AppLoaderIndicator({super.key, this.size =45, this.value});

  @override
  Widget build(BuildContext context) {
    return   Center(
      child: SpinKitSquareCircle(
        color: AppColors.white,
        size: size.sp,
      ),
    );
  }
}
