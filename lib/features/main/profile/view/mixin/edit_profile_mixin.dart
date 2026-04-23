import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import '../../../../../core/DI/setup_get_it.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../logic/edit_profile_cubit.dart';
import '../edit_profile_screen.dart';
import 'package:flutter/material.dart';
mixin EditProfileMixin on State<EditProfileScreen> {

  late final TextEditingController usernameController,
      phoneController,
      emailController,
      addressController;
  late final ValueNotifier<bool> isMaleNotifier;
  late DateTime? birthDate;
  final formKey = GlobalKey<FormState>();
  Country selectedCountry = userCubit.user!.country ?? AppConstants.initialCountry;
  EditProfileCubit get profileCubit => context.read<EditProfileCubit>();

  Future<void> onSave() async {
    if (formKey.currentState!.validate()) {
      profileCubit.editProfile(
        userCubit.user!.copyWith(
          fullName: usernameController.textOrNull,
          phone: phoneController.textOrNull,
          email: emailController.textOrNull,
          isMale: isMaleNotifier.value,
          country: selectedCountry,
          birthDate: birthDate,
        ),
      );
    }
  }
  @override
  void initState() {
    final u = userCubit.user;
    usernameController = TextEditingController(text: u?.fullName);
    phoneController = TextEditingController(text: u?.phone);
    emailController = TextEditingController(text: u?.email);
    addressController = TextEditingController(text: u?.address?.addressDisplay) ;
    isMaleNotifier = ValueNotifier(u?.isMale ?? true);
    birthDate = u?.birthDate;
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    isMaleNotifier.dispose();
    super.dispose();
  }

}