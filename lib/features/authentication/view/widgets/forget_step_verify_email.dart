import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/features/authentication/logic/forget_password_stepper_cubit.dart';

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
          AppStrings.weHaveSentYouAnEmailContainingConfirmation.tr(),
          style: TextStyles.labelLarge,
        ),
        Text(
          "${AppStrings.confirmationHasBeenSentToYourEmailAddress.tr()} ${stepper.email ?? ""}, ${AppStrings.pleaseClickTheURLInTheEmailToResetYourPassword.tr()}",
          style: TextStyles.captionMedium,
        ),
        Gap.medium(),
      ],
    );
  }
}
