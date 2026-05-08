import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/features/authentication/view/widgets/forget_password_form.dart';
import 'package:multi_vendor/features/main/profile/view/mixin/change_password_mixin.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}
class _ChangePasswordScreenState extends State<ChangePasswordScreen> with ChangePasswordMixin {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: AppStrings.changePassword.tr()),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            spacing: 16.h,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ChangePasswordForm(passwordController: passwordController, passwordConfirmController: confirmPasswordController),
              BaseBlocConsumer(
                bloc: cubit,
                onFailure:(e)=> onChangePasswordError(e),
                onSuccess:(_)=> onChangePasswordSuccess(),
                builder: (s) => AppButton(
                  text: AppStrings.changePassword.tr(),
                  isLoading: s.isLoading,
                  buttonSize: null,
                  onPressed: onChangePassword,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}


