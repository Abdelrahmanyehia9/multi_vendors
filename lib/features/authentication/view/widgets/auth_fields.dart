import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import '../../../../core/helper/app_validation.dart';
import '../../../../core/theme/decorations.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/widgets/app_click.dart';
import '../../../../core/widgets/app_text_field.dart';

class PasswordField extends StatefulWidget {
  final String hint;
  final String header;
  final String? Function(String?)? validator;
  const PasswordField({
    super.key,
    this.hint = "Enter Your Password",
    this.header = "Password",
    this.validator = AppValidation.validatePassword,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}
class _PasswordFieldState extends State<PasswordField> {
  final ValueNotifier<bool> _isObscured = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder(
        valueListenable: _isObscured,
        builder: (context, value, child) {
          return AppTextField(
            hintText: widget.hint,
            autoValidateMode: AutovalidateMode.disabled,
            borderType: AppBorderType.filled,
            validator: widget.validator,
            obscureText: value,
            suffix:  AppClick(
                onTap: ()=>_isObscured.value = !value,
                child: Icon(!value ? Icons.visibility : Icons.visibility_off)),
            headerText: widget.header,
          );
        }
    );
  }

  @override
  void dispose() {
    _isObscured.dispose();
    super.dispose();
  }
}
class EmailField extends StatelessWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppTextField(
      hintText: "Enter Your Email",
      headerText: "Email Address",
      validator: AppValidation.validateEmail,
      keyboardType: TextInputType.emailAddress,
      suffix: Icon(Icons.email),
      borderType: AppBorderType.filled,
    );
  }
}
class PhoneField extends StatelessWidget {
  const PhoneField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Phone Number", style: TextStyles.labelSmall,),
        IntlPhoneField(
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          initialCountryCode: 'EG',
          pickerDialogStyle: PickerDialogStyle(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            backgroundColor: context.scaffoldBackground,
            searchFieldInputDecoration: decoration(context, hintText: "search ...."),
          ),
          flagsButtonMargin: EdgeInsets.symmetric(horizontal: 16.w),
          onCountryChanged: (value) {},
          showDropdownIcon: false,
          decoration:decoration(context, hintText: "Enter  Phone Number",),
        ),
      ],
    );
  }
  InputDecoration  decoration (BuildContext context, {String? hintText, EdgeInsets? contentPadding}) {

    final   AppInputDecoration decoration = AppInputDecoration.instance.copyWith(
      hintText: hintText,
      padding: contentPadding,
    );
    return decoration.inputDecoration(context) ;
  }
}
