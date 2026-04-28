import 'package:flutter/material.dart';

import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';

class OtpColdDown extends StatelessWidget {
  const OtpColdDown({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      style: TextStyles.bodyMedium,
      TextSpan(
        text: "resend in""\t",
        children: [
          TextSpan(
            text: "00:55",
            style: TextStyles.bodyMedium.copyWith(color: AppColors.primary),
          ),
           const TextSpan(text:"\t""seconds",),
        ],
      ),
    );
  }
}
