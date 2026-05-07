import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';

class ToggleSignupAndLogin extends StatelessWidget {
  const ToggleSignupAndLogin({super.key,});

  @override
  Widget build(BuildContext context) {
    final String message =  AppStrings.dontHaveAnAccount.tr()  ;
    final String action = AppStrings.signUp.tr();
    return  Row(
      spacing: 8.w,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message, style: TextStyles.bodyMedium.copyWith(
            color: context.colors.surfaceContainer
        )),
        AppButton.text(text: action, style: TextStyles.labelMedium,
          onPressed: ()=>context.pushNamed(Routes.signup),
        ),
      ],
    );
  }
}
