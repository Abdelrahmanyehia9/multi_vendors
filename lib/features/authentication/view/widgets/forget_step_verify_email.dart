import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/gap.dart';
import '../../logic/forget_password_stepper_cubit.dart';

class ForgetStepVerifyEmail extends StatelessWidget {
  const ForgetStepVerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final stepper = context.read<ForgetPasswordStepperCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Gap.small(),
        Text(
          "We have sent you an email containing confirmation",
          style: TextStyles.labelLarge,
        ),
        Text(
          "Confirmation has been sent to your email address ${stepper.email ?? ""}, please click the URL in the email to reset your password",
          style: TextStyles.captionMedium,
        ),
        Gap.medium(),
      ],
    );
  }
}
