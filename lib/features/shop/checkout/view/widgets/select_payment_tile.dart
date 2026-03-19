import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/section_header.dart';

class SelectPaymentTile extends StatelessWidget {
  const SelectPaymentTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(title: "Select Payment"),
        AppTextField(
          style: TextStyles.captionMedium,
          initialValue: "Pay at shop",
          readOnly: true,
          suffix: Icon(
            Icons.check_circle_outline,
            color: AppColors.primary,
            size: 20.sp,
          ),
        ),
      ],
    );
  }
}
