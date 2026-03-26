import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/core/widgets/app_button.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/main/profile/view/widgets/change_profile_pic.dart';
import 'package:multi_vendor/features/main/profile/view/widgets/edit_profile_form.dart';
import '../../../../core/models/base_user_model.dart';
import '../../../../core/widgets/scaffold/base_appbar.dart';
import '../logic/edit_profile_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController usernameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final ValueNotifier<bool> isMaleNotifier;
  late final TextEditingController addressController;
  late DateTime? birthDate;
  late Country _selectedCountry ;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  EditProfileCubit get profileCubit => context.read<EditProfileCubit>();


  Future<void> _onSave() async {
    if (formKey.currentState!.validate()) {
     final newUser =   userCubit.user!.copyWith(
          fullName: usernameController.text.trim(),
          phone: _selectedCountry.dialCode + phoneController.text.trim(),
          email: emailController.text.trim(),
          address: addressController.text.trim(),
          isMale: isMaleNotifier.value,
          birthDate: birthDate,
        );
      profileCubit.editProfile(newUser);
    }
  }

  @override
  void initState() {
    super.initState();
    final BaseUserModel? u = userCubit.user;
    late final String? purePhone;
    _selectedCountry = u?.country ?? AppConstants.initialCountry;
    if(u!=null && u.phone != null){
      purePhone  = u.phone!.replaceFirst(u.country?.dialCode??"" , '');
    } else{
      purePhone = u?.phone ;
    }
    usernameController = TextEditingController(text: u?.fullName);
    phoneController = TextEditingController(text: purePhone);
    emailController = TextEditingController(text: u?.email);
    addressController = TextEditingController(text: u?.address);
    isMaleNotifier = ValueNotifier<bool>(u?.isMale ?? true);
    birthDate = u?.birthDate;
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
                onBirthDateSelected: (date) {
                  birthDate = date;
                },
                addressController: addressController,
              ),
            ),
            BaseBlocConsumer(
              onSuccess: (e)=>context.successBar(message: "Profile Updated Successfully"),
              onEmpty: ()=>context.warningBar(message: "You're all set! No changes made"),
              onFailure: (e)=>context.errorBar(message: e.message),
              bloc: profileCubit,
              builder: (state) => AppButton(
                text: "Saved",
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
    final controllers = [
      usernameController,
      phoneController,
      emailController,
      addressController,
    ];
    for (var c in controllers) {
      c.dispose();
    }
    isMaleNotifier.dispose();
    super.dispose();
  }
}
