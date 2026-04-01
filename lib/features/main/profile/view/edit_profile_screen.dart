import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/core/widgets/app_button.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/main/profile/view/widgets/change_profile_pic.dart';
import 'package:multi_vendor/features/main/profile/view/widgets/edit_profile_form.dart';
import '../../../../core/widgets/scaffold/base_appbar.dart';
import '../logic/edit_profile_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController usernameController,
      phoneController,
      emailController,
      addressController;
  late final ValueNotifier<bool> isMaleNotifier;
  late DateTime? birthDate;
  final formKey = GlobalKey<FormState>();
  Country _selectedCountry = userCubit.user!.country ?? AppConstants.initialCountry;
  EditProfileCubit get profileCubit => context.read<EditProfileCubit>();

  Future<void> _onSave() async {
    if (formKey.currentState!.validate()) {
      profileCubit.editProfile(
        userCubit.user!.copyWith(
          fullName: usernameController.textOrNull,
          phone: phoneController.textOrNull,
          email: emailController.textOrNull,
          address: addressController.textOrNull,
          isMale: isMaleNotifier.value,
          country: _selectedCountry,
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
    addressController = TextEditingController(text: u?.address);
    isMaleNotifier = ValueNotifier(u?.isMale ?? true);
    birthDate = u?.birthDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: "Edit Profile"),
      body: SingleChildScrollView(
        child: Column(
          spacing: 16.sp,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ChangeProfilePic(),
            Form(
              key: formKey,
              child: EditProfileForm(
                onCountryChanged: (c) => _selectedCountry = c,
                usernameController: usernameController,
                phoneController: phoneController,
                emailController: emailController,
                isMaleNotifier: isMaleNotifier,
                onBirthDateSelected: (d) => birthDate = d,
                addressController: addressController,
              ),
            ),
            BaseBlocConsumer(
              bloc: profileCubit,
              onSuccess: (_) => context.successBar(message: "Updated"),
              onEmpty: () => context.warningBar(message: "No changes"),
              onFailure: (e) => context.errorBar(message: e.message),
              builder: (state) => AppButton(
                text: "Save",
                isLoading: state.isLoading,
                onPressed: _onSave,
                buttonSize: null,
              ),
            ),
          ],
        ),
      ),
    );
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

