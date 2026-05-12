import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/main/profile/view/widgets/change_profile_pic.dart';
import 'package:multi_vendor/features/main/profile/view/widgets/edit_profile_form.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/features/main/profile/view/mixin/edit_profile_mixin.dart';
import 'package:multi_vendor/shared/logic/image_handle_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with EditProfileMixin  {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: AppStrings.editProfile.tr()),
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
              onSuccess: (_) {
                context.successBar(message: AppStrings.userUpdatedSuccessfully.tr());
                context.read<ImageHandleCubit>().reset();
              },
              onEmpty: () =>context.warningBar(message: AppStrings.noChanges),
              onFailure: (e) => context.errorBar(message: e.message),
              builder: (state) => AppButton(
                text: AppStrings.save.tr(),
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
