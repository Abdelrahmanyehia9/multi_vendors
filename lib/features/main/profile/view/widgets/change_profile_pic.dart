import 'package:flutter/material.dart';

import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/widgets/buttons/app_button.dart';
import '../../../../../core/widgets/gap.dart';
import '../../../../../core/widgets/user_avatar.dart';

class ChangeProfilePic extends StatefulWidget {
  const ChangeProfilePic({super.key});

  @override
  State<ChangeProfilePic> createState() => _ChangeProfilePicState();
}

class _ChangeProfilePicState extends State<ChangeProfilePic> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(child: UserAvatar(size: 100)),
        Gap.small(),
        AppButton.text(text: "Change Profile Photo", style: TextStyles.labelSmall,)
      ],
    );
  }
}
