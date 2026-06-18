import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:multi_vendor/core/service/url_launcher.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';

class AgreePrivacyPolicy extends StatelessWidget {
  const AgreePrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyles.bodySmall,
        text: "${AppStrings.agreePrivacyPolicy.tr()}\t",
        children: [
          TextSpan(
            text: AppStrings.privacyPolicy.tr(),
            style: TextStyles.labelSmall.copyWith(color: AppColors.primary),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                await UrlLauncherService.instance.launchUrlString(
                  AppConstants.privacyPolicyUrl,
                  mode: LaunchMode.externalApplication,
                );
              },
          ),
        ],
      ),
    );
  }
}
