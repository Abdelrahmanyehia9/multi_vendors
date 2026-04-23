import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/main/profile/view/widgets/change_profile_pic.dart';
import 'package:multi_vendor/features/main/profile/view/widgets/edit_profile_form.dart';
import '../../../../core/widgets/scaffold/base_appbar.dart';
import 'mixin/edit_profile_mixin.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>  with EditProfileMixin{
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
                onCountryChanged: (c) => selectedCountry = c,
                usernameController: usernameController,
                phoneController: phoneController,
                emailController: emailController,
                isMaleNotifier: isMaleNotifier,
                addressController: addressController,
                onBirthDateSelected: (d) => birthDate = d,
              ),
            ),
            BaseBlocConsumer(
              bloc: profileCubit,
              onSuccess: (_) => context.successBar(message: "User updated successfully"),
              onEmpty: () => context.warningBar(message: "No changes"),
              onFailure: (e) => context.errorBar(message: e.message),
              builder: (state) => AppButton(
                text: "Save",
                isLoading: state.isLoading,
                onPressed: onSave,
                buttonSize: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



