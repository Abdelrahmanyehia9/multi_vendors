import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/utils/app_configs.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/features/authentication/view/widgets/auth_fields.dart';
import 'package:multi_vendor/features/main/profile/view/widgets/profile_text_fields.dart';
import 'package:multi_vendor/core/enum/login_providers.dart';
import 'package:multi_vendor/core/widgets/app_text_field.dart';
import 'package:multi_vendor/features/main/profile/data/model/address_model.dart';

class EditProfileForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController addressController;
  final ValueNotifier<bool> isMaleNotifier;
  final ValueChanged<DateTime> onBirthDateSelected;
  final ValueChanged<Country> onCountryChanged;

  const EditProfileForm({
    super.key,
    required this.usernameController,
    required this.phoneController,
    required this.emailController,
    required this.isMaleNotifier,
    required this.onBirthDateSelected,
    required this.onCountryChanged,
    required this.addressController,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEmailProvided =
        AppConfigs.authFormType == AuthFormType.emailAndPassword;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.h,
      children: [
        _textField(label: AppStrings.fullName.tr(), controller: usernameController),
        EmailField(
          readOnly: isEmailProvided,
          nullable: true,
          controller: emailController,
        ),
        PhoneField(
          readOnly: !isEmailProvided,
          onCountryChanged: onCountryChanged,
          controller: phoneController,
        ),
        GenderSelector(isMaleNotifier),
        BirthDateField(
          initialDate: userCubit.user?.birthDate,
          onSelected: onBirthDateSelected,
        ),
        _textField(
          label: AppStrings.address.tr(),
          maxLines: 2,
          controller: addressController,
          readOnly: true,
          onTap: () async {
            final AddressModel? address = await context.pushNamed(
              Routes.address,
            );
            if (address != null) {
              addressController.text = address.addressDisplay;
            }
          },
        ),
      ],
    );
  }

  Widget _textField({
    required String label,
    int? maxLines,
    TextEditingController? controller,
    int? maxLength,
    String? initialValue,
    bool readOnly = false,
    void Function()? onTap,
  }) => AppTextField(
    borderWidth: 1.2,
    maxLines: maxLines ?? 1,
    borderType: AppBorderType.filled,
    hintText: "${AppStrings.enter.tr()} $label",
    controller: controller,
    headerText: label,
    maxLength: maxLength,
    initialValue: initialValue,
    readOnly: readOnly,
    onTap: onTap,
  );
}
