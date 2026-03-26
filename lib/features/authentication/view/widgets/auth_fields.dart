import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../core/helper/app_validation.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/decorations.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/app_click.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/gap.dart';

class PasswordField extends StatefulWidget {
  final String hint;
  final String header;
  final bool readOnly;

  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const PasswordField({
    super.key,
    this.readOnly = false,
    this.hint = "Enter Your Password",
    this.header = "Password",
    this.controller,
    this.validator = AppValidation.validatePassword,
  });

  factory PasswordField.confirm({
    required String password,
    required TextEditingController controller,
  }) => PasswordField(
    hint: "Enter Confirm Password",
    header: "Confirm Password",
    controller: controller,
    validator: (v) => AppValidation.validatePasswordConfirmation(password, v),
  );

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final ValueNotifier<bool> _isObscured = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isObscured,
      builder: (context, value, child) {
        return AppTextField(
          hintText: widget.hint,
          controller: widget.controller,
          autoValidateMode: AutovalidateMode.disabled,
          borderType: AppBorderType.filled,
          validator: widget.validator,
          obscureText: value,
          suffix: AppClick(
            onTap: () => _isObscured.value = !value,
            child: Icon(!value ? Icons.visibility : Icons.visibility_off),
          ),
          headerText: widget.header,
        );
      },
    );
  }

  @override
  void dispose() {
    _isObscured.dispose();
    super.dispose();
  }
}

class EmailField extends StatelessWidget {
  final TextEditingController? controller;

  final bool readOnly;

  const EmailField({super.key, this.readOnly = false, this.controller});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      readOnly: readOnly,
      enabled: !readOnly,
      hintText: "Enter Your Email",
      controller: controller,
      headerText: "Email Address",
      validator: AppValidation.validateEmail,
      keyboardType: TextInputType.emailAddress,
      suffix: const Icon(Icons.email),
      borderType: AppBorderType.filled,
    );
  }
}

class PhoneField extends StatelessWidget {
  final TextEditingController? controller;

  final bool readOnly;

  final void Function(Country)? onCountryChanged;

  const PhoneField({
    super.key,
    this.readOnly = false,
    this.controller,
    this.onCountryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Phone Number", style: TextStyles.labelSmall),
        IntlPhoneField(
          readOnly: readOnly,
          enabled: !readOnly,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          initialCountryCode: userCubit.user?.country?.code ?? AppConstants.initialCountry.code,
          controller: controller,
          pickerDialogStyle: PickerDialogStyle(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            backgroundColor: context.scaffoldBackground,
            searchFieldInputDecoration: decoration(
              context,
              hintText: "search ....",
            ),
          ),
          flagsButtonMargin: EdgeInsets.symmetric(horizontal: 16.w),
          onCountryChanged: onCountryChanged,
          showDropdownIcon: false,
          decoration: decoration(context, hintText: "Enter  Phone Number"),
        ),
      ],
    );
  }

  InputDecoration decoration(
    BuildContext context, {
    String? hintText,
    EdgeInsets? contentPadding,
  }) {
    final AppInputDecoration decoration = AppInputDecoration.instance.copyWith(
      hintText: hintText,
      padding: contentPadding,
    );
    return decoration.inputDecoration(context);
  }
}

class PinCode extends StatelessWidget {
  final PinInputController controller;
  final ValueChanged<String>? onComplete;
  const PinCode({super.key,this.onComplete ,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: MaterialPinField(
        pinController: controller,
        onCompleted: onComplete,
        theme: MaterialPinTheme(
          fillColor: context.colors.surfaceContainerLowest,
          borderColor: Colors.transparent,
          cellSize: Size(50.w, 50.h),
          errorFillColor: AppColors.error,
          shape: MaterialPinShape.filled,
          textStyle: TextStyles.bodyMedium,
          completeTextStyle: TextStyles.bodyMedium.copyWith(
            color: AppColors.success600,
          ),
          filledFillColor: AppColors.success600.withAppOpacity(0.1),
          filledBorderColor: AppColors.success600,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        length: 6,
        separatorBuilder: (context, position) => Gap.small(),
      ),
    );
  }
}
