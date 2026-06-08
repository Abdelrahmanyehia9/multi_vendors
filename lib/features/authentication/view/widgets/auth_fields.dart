import 'dart:async';

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_configs.dart';
import 'package:multi_vendor/core/utils/helper/app_validation.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/app_text_field.dart';


class PasswordField extends StatefulWidget {
  final String hint;
  final String header;
  final bool readOnly;

  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const PasswordField({
    super.key,
    this.readOnly = false,
    this.hint = AppStrings.password,
    this.header = AppStrings.password,
    this.controller,
    this.validator = AppValidation.validatePassword,
  });

  factory PasswordField.confirm({
    required TextEditingController passwordController,
    required TextEditingController passwordConfirmController,
  }) => PasswordField(
    hint: AppStrings.confirmPassword,
    header: AppStrings.confirmPassword,
    controller: passwordConfirmController,
    validator: (v) => AppValidation.validatePasswordConfirmation(passwordController.text, v),
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
          hintText: "${AppStrings.enter.tr()} ${widget.hint.tr()}",
          controller: widget.controller,
          autoValidateMode: AutovalidateMode.disabled,
          borderType: AppBorderType.filled,
          validator: widget.validator,
          obscureText: value,
          suffix: AppClick(
            onTap: () => _isObscured.value = !value,
            child: Icon(!value ? MvIcons.visibility : MvIcons.visibilityOff),
          ),
          headerText: widget.header.tr(),
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
 final bool nullable ;
  final bool readOnly;

  const EmailField({super.key,this.nullable = false ,this.readOnly = false, this.controller});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      readOnly: readOnly,
      enabled: !readOnly,
      hintText: "${AppStrings.enter.tr()} ${AppStrings.emailAddress.tr()}",
      controller: controller,
      headerText: AppStrings.emailAddress.tr(),
      validator:(v)=> AppValidation.validateEmail(v, nullable),
      keyboardType: TextInputType.emailAddress,
      suffix:  const Icon(MvIcons.email),
      borderType: AppBorderType.filled,
    );
  }
}

class PhoneField extends StatelessWidget {
  final TextEditingController? controller;

   final bool readOnly;
    final FutureOr<String?> Function(PhoneNumber?)? validator ;
  final void Function(Country)? onCountryChanged;

  const PhoneField({
    super.key,
    this.readOnly = false,
    this.controller,
    this.onCountryChanged,
    this.validator ,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.phoneNumber.tr(), style: TextStyles.labelSmall),
        Directionality(
          textDirection: TextDirection.ltr,
          child: IntlPhoneField(
            readOnly: readOnly,
            enabled: !readOnly,
            validator :validator,
            autovalidateMode: validator == null ? null : AutovalidateMode.always,
            invalidNumberMessage: AppStrings.enterInvalidPhone.tr(),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            initialCountryCode: userCubit.user?.country?.code ?? AppConfigs.initialCountry.code,
            controller: controller,
            pickerDialogStyle: PickerDialogStyle(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              backgroundColor: context.scaffoldBackground,
              searchFieldInputDecoration: decoration(
                context,
                hintText: "${AppStrings.search.tr()} ....",
              ),
            ),
            flagsButtonMargin: EdgeInsets.symmetric(horizontal: 16.w),
            onCountryChanged: onCountryChanged,
            showDropdownIcon: false,
            decoration: decoration(context, hintText: "${AppStrings.enter.tr()} ${AppStrings.phoneNumber.tr()}"),
          ),
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
      filledColor: readOnly ? context.colors.surfaceContainerLowest.darken() :null,
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
