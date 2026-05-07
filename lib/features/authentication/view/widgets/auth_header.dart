import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_assets.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Center(
          child: SvgPicture.asset(AppAssets.appLogo, width: 50.w, height: 50.h),
        ),
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
