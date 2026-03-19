import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/widgets/app_button.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/main/profile/view/widgets/change_profile_pic.dart';
import 'package:multi_vendor/features/main/profile/view/widgets/edit_profile_form.dart';
import '../../../../core/widgets/scaffold/base_appbar.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: "Edit Profile"),
      body: SingleChildScrollView(
        child:  Column(
          spacing: 16.sp,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            ChangeProfilePic(),
            EditProfileForm(),
            AppButton(text: "Saved", buttonSize: null,)
          ],
        ),
      ),
    );
  }
}



