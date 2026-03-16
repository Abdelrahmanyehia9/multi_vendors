import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    if(!AppConstants.enableForgetPassword){
      return const SizedBox.shrink();
    }
    return Align(
        alignment: AlignmentDirectional.topEnd,
        child: Text("Forget Password ? ", style: TextStyles.labelSmall.copyWith(color: AppColors.primary),)).paddingVr(4);
  }
}
