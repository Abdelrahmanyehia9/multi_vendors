import 'package:flutter/material.dart';

import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';


class SloganText extends StatelessWidget {
  const SloganText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "Discover Your Best ",
        style: TextStyles.labelLarge,
        children: [
          TextSpan(
            text: "Fashion !",
            style: TextStyles.labelLarge.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
