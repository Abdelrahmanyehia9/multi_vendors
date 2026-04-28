import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/enum/order_status.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/shared/view/widgets/section_header.dart';

class OrderTrackingTimeLine extends StatelessWidget {
  final TrackStatus status;
  const OrderTrackingTimeLine({super.key, required this.status});
  List<TrackingStep> get steps {
    final currentIndex = TrackStatus.values.indexOf(status);
    return TrackStatus.values.asMap().entries.map((entry) {
      final index = entry.key;
      final s = entry.value;

      return TrackingStep(s, index <= currentIndex, index < currentIndex);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 18.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: "Order TimeLine"),
          ...steps.asMap().entries.map((entry) {
            final isLast = entry.key == steps.length - 1;
            return _buildTimelineItem(entry.value, isLast);
          }),
        ],
      );
  }

  Widget _buildTimelineItem(TrackingStep step, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 26.r,
              height: 26.r,
              decoration: BoxDecoration(
                color: step.isActive
                    ? AppColors.success600
                    : Colors.grey.withAppOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                step.isCompleted || (step.isActive && isLast) ? Icons.check : Icons.circle,
                color: step.isActive ? Colors.white : Colors.grey,
                size: 16.sp,
              ),
            ),
            if (!isLast)
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.h),
                width: 1.w,
                height: 30.h,
                color: Colors.grey.withAppOpacity(0.5),
              ),
          ],
        ),
        const Gap(16),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.status.title,
                  style: TextStyles.labelMedium.copyWith(
                    color: step.isActive ? null : Colors.grey,
                  ),
                ),
                Text(
                  step.status.description ,
                  style: TextStyles.captionMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


class TrackingStep {
  final TrackStatus status;
  final bool isActive;
  final bool isCompleted;

  TrackingStep(this.status, this.isActive, this.isCompleted);
}
