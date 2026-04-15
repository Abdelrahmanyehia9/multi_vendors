import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/text_styles.dart';

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
