import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/widgets/app_button.dart';
import 'package:multi_vendor/core/widgets/app_text_field.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import '../../../../core/widgets/forget_password_button.dart';
import '../../../../core/widgets/gap.dart';
import '../../../../core/widgets/scaffold/base_appbar.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BaseScaffold(
      appBar: BaseAppBar(
        title: "Change Password",
      ),
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
         _textField(label: "Current Password"),
         const ForgetPasswordButton(),
         Divider(height: 36.h,),
         _textField(label: "New Password"),
          Gap.medium(),
         _textField(label: "Confirm Password"),
          Gap.large(),
          const AppButton(
            text: "Change Password", buttonSize: null,),
        ],
      ),
    );


  }
  Widget _textField({required String label, int? maxLines, bool readOnly = false})=>AppTextField(
    borderWidth: 1.2,
    maxLines: maxLines??1,
    readOnly: readOnly,
    hintText: "Enter $label",headerText: label,);
}
