import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/widgets/app_steps_header.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/authentication/logic/forget_password_stepper_cubit.dart';
import 'package:multi_vendor/features/authentication/view/widgets/forget_step_reset_password.dart';
import 'package:multi_vendor/features/authentication/view/widgets/forget_step_send_email.dart';
import 'package:multi_vendor/features/authentication/view/widgets/forget_step_verify_email.dart';

import '../../../core/widgets/buttons/app_back_button.dart';

class ForgetPasswordArgs{
  final String? email  ;
  final int initialStep ;
  ForgetPasswordArgs({this.email,this.initialStep = 0});

}



class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {


  List<Widget> steps = [
    const ForgetStepSendEmail(),
    const ForgetStepVerifyEmail(),
    const ForgetStepResetPassword()
  ];
  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<ForgetPasswordStepperCubit, int>(
      successBuilder: (step) =>
          BaseScaffold(
            appBar: BaseAppBar(title: "Forget Password", leading: _buildLeading(step != 0)),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8.h,
                children: [
                  AppStepsHeader(activeStep: step, totalSteps: steps.length),
                  steps[step],
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildLeading(bool canPop) {
    return AppBackButton(onBack: () {
      if (canPop) {
        context.read<ForgetPasswordStepperCubit>().previousStep() ;
      } else {
        context.pop();
      }
    });
  }
}


