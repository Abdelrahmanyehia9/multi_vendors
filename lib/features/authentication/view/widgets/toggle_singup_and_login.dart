import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';

class ToggleSignupAndLogin extends StatelessWidget {
  const ToggleSignupAndLogin({super.key,});

  @override
  Widget build(BuildContext context) {
    final String message =  "Don’t have an account?"  ;
    final String action = "Sign up";
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
