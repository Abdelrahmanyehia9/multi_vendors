import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:multi_vendor/core/service/url_launcher.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AgreePrivacyPolicy extends StatelessWidget {
  const AgreePrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyles.bodySmall,
        text: "By signing up you agree to our ",
        children: [
          TextSpan(
            text: "privacy policies",
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
