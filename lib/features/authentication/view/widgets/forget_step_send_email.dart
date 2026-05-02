import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/features/authentication/logic/forget_password_send_email_cubit.dart';
import 'package:multi_vendor/features/authentication/logic/forget_password_stepper_cubit.dart';
import 'package:multi_vendor/features/authentication/view/widgets/auth_fields.dart';

class ForgetStepSendEmail extends StatefulWidget {
  const ForgetStepSendEmail({super.key});

  @override
  State<ForgetStepSendEmail> createState() => _ForgetStepSendEmailState();
}

class _ForgetStepSendEmailState extends State<ForgetStepSendEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ForgetPasswordSendEmailCubit get _sendEmailCubit => context.read<ForgetPasswordSendEmailCubit>();
  ForgetPasswordStepperCubit get stepper => context.read<ForgetPasswordStepperCubit>();

  void _sendConfirmation() {
    if (_formKey.currentState!.validate()) {
      _sendEmailCubit.sendForgetLink(email: stepper.emailController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [
          Gap.small(),
          Text("Reset Your Password", style: TextStyles.labelLarge),
          Text(
            "To reset your password, please enter your registered email",
            style: TextStyles.captionMedium,
          ),
          Gap.medium(),
          EmailField(controller: stepper.emailController),
          BaseBlocConsumer(
            bloc: _sendEmailCubit,
            onFailure: (e) => context.errorBar(message: e.message),
            onSuccess: (_) => stepper.nextStep(),
            builder: (s) => AppButton(
              text: "send confirmation",
              buttonSize: null,
              isLoading: s.isLoading,
              onPressed: _sendConfirmation,
            ),
          ),
        ],
      ),
    );
  }
}
