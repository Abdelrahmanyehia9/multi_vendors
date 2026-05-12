import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/app_logo.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         const AppLogo(),
        Text(
          AppStrings.welcomeBack.tr(),
          textAlign: TextAlign.center,
          style: TextStyles.labelLarge,
        ),
        Text(
          AppStrings.pleasFillFormBelowToLogin.tr(),
          textAlign: TextAlign.center,
          style: TextStyles.captionMedium,
        ),
      ],
    );
  }
}
