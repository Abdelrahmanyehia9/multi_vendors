import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/types/type_def.dart';
import 'package:multi_vendor/core/widgets/app_button.dart';
import 'package:multi_vendor/core/widgets/user_avatar.dart';
import 'package:multi_vendor/features/main/profile/view/widgets/profile_list_tile.dart';
import '../../../../core/widgets/gap.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static final List<ListTileData> _items = [
    ("Edit Profile", Icons.edit, (context)=>context.pushNamed(Routes.editProfile)),
    ("Change Password", Icons.lock, (context)=>context.pushNamed(Routes.changePassword)),
    ("Settings", Icons.settings, (context)=>context.pushNamed(Routes.settings)),
    ("Rate us", Icons.star, (_){}),
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("Profile", style: TextStyles.labelLarge).appPaddingVr,
          const Center(child: UserAvatar(size: 100)).appPaddingVr,
          Gap.extraLarge(),
          ..._items.expand((e) => [
            ProfileListTile(title: e.$1, icon: e.$2!, onTap: e.$3),
            const Divider(),
          ]
          ),
          Gap.large(),
          Text(
            "version 1.1.2",
            style: TextStyles.captionMedium.copyWith(color: AppColors.grey),
          ),
          AppButton.text(text: "Logout"),
        ],
      ).appPaddingHr,
    );
  }
}