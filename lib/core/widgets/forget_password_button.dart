import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/features/authentication/view/forget_password_screen.dart';
import '../routes/routes.dart';

class ForgetPasswordButton extends StatelessWidget {
  final String?  email  ;
  const ForgetPasswordButton({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    if(!FeatureFlags.enableForgetPassword){
      return const SizedBox.shrink();
    }
    return Align(
        alignment: AlignmentDirectional.topEnd,
        child: AppClick(
          onTap: ()=>context.pushNamed(Routes.forgetPassword, arguments: ForgetPasswordArgs(email: email)),
          child: Text(
             "Forget Password ? ", style: TextStyles.labelSmall.copyWith(color: AppColors.primary),),
        )).paddingVr(4);
  }
}
