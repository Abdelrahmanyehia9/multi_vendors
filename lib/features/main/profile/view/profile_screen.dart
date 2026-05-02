import 'package:flutter/material.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/types/type_def.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/features/main/profile/view/widgets/profile_list_tile.dart';
import 'package:multi_vendor/core/enum/login_providers.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/shared/view/widgets/login_required.dart';
import 'package:multi_vendor/shared/view/widgets/user_avatar.dart';
import 'package:multi_vendor/shared/view/widgets/user_builder.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static final List<ListTileData> _items = [
    (
      "Edit Profile",
      MvIcons.edit,
      (context) => context.pushNamed(Routes.editProfile),
    ),
    if (AppConstants.authFormType == AuthFormType.emailAndPassword)
      (
        "Change Password",
        MvIcons.lock,
        (context) => context.pushNamed(Routes.changePassword),
      ),
    (
      "Settings",
      MvIcons.settings,
      (context) => context.pushNamed(Routes.settings),
    ),
    ("Rate us", MvIcons.star, (_) {}),
  ];

  @override
  Widget build(BuildContext context) {
    return LoginRequired(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("Profile", style: TextStyles.labelLarge).appPaddingVr,
            UserBuilder(
              builder: (u)=> Center(
                child: Column(
                  children: [
                     UserAvatar(

                       size: 100, profile: u?.profilePic,),
                    Gap.small(),
                    Text(userCubit.userName, style: TextStyles.labelMedium),
                    Text(
                      userCubit.user?.email ?? userCubit.user?.phone ?? "",
                      style: TextStyles.bodyMedium.copyWith(
                        color: context.colors.surfaceContainerLow,
                      ),
                    ),
                  ],
                ),
              ).appPaddingVr,
            ),
            Gap.extraLarge(),
            ..._items.expand(
              (e) => [
                ProfileListTile(title: e.$1, icon: e.$2!, onTap: e.$3),
                const Divider(),
              ],
            ),
            Gap.large(),
            Text(
              "version 1.1.2",
              style: TextStyles.captionMedium.copyWith(color: AppColors.grey),
            ),
            AppButton.text(text: "Logout", onPressed: userCubit.logout),
          ],
        ).appPaddingHr,
      ),
    );
  }
}
