import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';

import '../theme/app_colors.dart';
import '../theme/decorations.dart';

class AppStepsHeader extends StatelessWidget {
  final int activeStep ;
  final int totalSteps ;
  const AppStepsHeader({super.key, required this.activeStep, required this.totalSteps});

  @override
  Widget build(BuildContext context) {
    final double width = context.width * .85;
    final isRTL = context.isRTL;
    final double activeStepWidth = activeStep * (width / totalSteps);
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: width,
            height: 10.h,
            alignment: AlignmentDirectional.topStart,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: context.colors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(Decorations.borderRadius8.r),
            ),
            child: Container(width: activeStepWidth, color: AppColors.primary),
          ),
          Positioned(
            top: -24.h,
            right: isRTL ? activeStepWidth +16.w : null,
            left: isRTL ? null : activeStepWidth -16.w,
            child: const Icon(Icons.check_circle, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
