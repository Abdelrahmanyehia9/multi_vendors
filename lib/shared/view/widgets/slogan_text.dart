import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';


class SloganText extends StatelessWidget {
  const SloganText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "${AppStrings.discoverYourBest.tr()}\t",
        style: TextStyles.labelLarge,
        children: [
          TextSpan(
            text: AppStrings.fashion.tr(),
            style: TextStyles.labelLarge.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
