import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/widgets/overlays/dialogues.dart';
import 'package:multi_vendor/shared/view/widgets/message_alert.dart';
import 'package:multi_vendor/features/authentication/logic/forget_password_change_password_cubit.dart';
import 'package:multi_vendor/features/authentication/view/widgets/forget_password_form.dart';

class ForgetStepResetPassword extends StatefulWidget {
  const ForgetStepResetPassword({super.key});

  @override
  State<ForgetStepResetPassword> createState() =>
      _ForgetStepResetPasswordState();
}

class _ForgetStepResetPasswordState extends State<ForgetStepResetPassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ForgetPasswordChangePasswordCubit get _changePasswordCubit =>
      context.read<ForgetPasswordChangePasswordCubit>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.h,
      children: [
        Form(
          key: _formKey,
          child: ChangePasswordForm(
            passwordController: _passwordController,
            passwordConfirmController: _confirmPasswordController,
          ),
        ),
        BaseBlocConsumer(
          bloc: _changePasswordCubit,
          onFailure: (e) => context.errorBar(message: e.message),
          onSuccess: (_) async {
           await Popups.show(
              context,
              showCloseButton: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const MessageAlert(MessagesAlertType.resetPasswordSuccess),
                  Gap.medium(),
                  AppButton(text: AppStrings.confirm.tr(), buttonSize: null, onPressed: context.pop,)
                ],
              ),
            ).whenComplete(() {
          if(context.mounted) {
            context.pushNamedAndRemoveUntil(
              Routes.mainLayout,
              predicate: (route) => false,
            );
          }
            });
          },
          builder: (s) => AppButton(
            text: AppStrings.resetPassword.tr(),
            isLoading: s.isLoading,
            buttonSize: null,
            onPressed: () => _changePasswordCubit.changePassword(
              newPassword: _passwordController.text,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
