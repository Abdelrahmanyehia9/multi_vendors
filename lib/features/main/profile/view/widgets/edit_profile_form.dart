import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/features/authentication/view/widgets/auth_fields.dart';
import 'package:multi_vendor/features/main/profile/view/widgets/profile_text_fields.dart';
import '../../../../../core/enum/login_providers.dart';
import '../../../../../core/widgets/app_text_field.dart';

class EditProfileForm extends StatelessWidget {
  final TextEditingController usernameController ;
  final TextEditingController phoneController ;
  final TextEditingController emailController ;
  final ValueNotifier<bool> isMaleNotifier ;
  final ValueChanged<DateTime> onBirthDateSelected;
  final TextEditingController addressController ;
  final ValueChanged<Country> onCountryChanged;

  const EditProfileForm({super.key,
    required this.usernameController,
    required this.phoneController,
    required this.emailController,
    required this.isMaleNotifier,
    required this.onBirthDateSelected,
    required this.addressController,
    required this.onCountryChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEmailProvided = AppConstants.authFormType == AuthFormType.emailAndPassword;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.h,
      children: [
        _textField(label: "Full Name", controller: usernameController),
         EmailField(
           readOnly: isEmailProvided,
           controller: emailController,),
         PhoneField(
           readOnly: !isEmailProvided,
           onCountryChanged: onCountryChanged,
           controller: phoneController ,),
        GenderSelector(isMaleNotifier),
        BirthDateField(
            initialDate: userCubit.user?.birthDate,
            onSelected: onBirthDateSelected),
        _textField(
            maxLength: 256,
            label: "Address",
            controller: addressController,
            maxLines: 2),
      ],
    );
  }

  Widget _textField({
    required String label,
    int? maxLines,
    TextEditingController? controller,
    int? maxLength,
  }) => AppTextField(
    borderWidth: 1.2,
    maxLines: maxLines ?? 1,
    borderType: AppBorderType.filled,
    hintText: "Enter $label",
    controller: controller,
    headerText: label,
    maxLength: maxLength,

  );

}


