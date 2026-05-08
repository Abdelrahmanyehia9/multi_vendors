import 'package:easy_localization/easy_localization.dart';
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
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/helper/app_review_helper.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/overlays/dialogues.dart';
import 'package:multi_vendor/features/main/profile/view/widgets/profile_list_tile.dart';
import 'package:multi_vendor/core/enum/login_providers.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/shared/view/widgets/user_avatar.dart';
import 'package:multi_vendor/shared/view/widgets/user_builder.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final List<ListTileData> items = [
      if(!userCubit.isGuest)
        (
        AppStrings.editProfile.tr(),
        MvIcons.edit,
            (context) => context.pushNamed(Routes.editProfile),
        ),
      if (AppConstants.authFormType == AuthFormType.emailAndPassword && !userCubit.isGuest)
        (
        AppStrings.changePassword.tr(),
        MvIcons.lock,
            (context) => context.pushNamed(Routes.changePassword),
        ),
      (
      AppStrings.settings.tr(),
      MvIcons.settings,
          (context) => context.pushNamed(Routes.settings),
      ),
      (AppStrings.rateUs.tr(), MvIcons.star, (_) async{
        await AppReviewHelper.instance.openStoreListener() ;
      }
      ),
      (AppStrings.contactUs.tr(), MvIcons.support, (context) {
        context.pushNamed(Routes.contactUs) ;
      }
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          Text(AppStrings.profile.tr(), style: TextStyles.labelLarge).appPaddingVr,
          UserBuilder(
            builder: (u) =>
            Center(
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
          ...items.expand(
                (e) =>
            [
              ProfileListTile(title: e.$1, icon: e.$2!, onTap: e.$3),
              const Divider(),
            ],
          ),
          Gap.large(),
          Text(
            "${AppStrings.version.tr()} 1.1.2",
            style: TextStyles.captionMedium.copyWith(color: AppColors.grey),
          ),
          if(!userCubit.isGuest)
          AppButton.text(text: AppStrings.logout.tr(), onPressed: ()=>_onLogout(context))else
          AppButton.text(text: AppStrings.login.tr(), onPressed: (){
              context.pushNamed(Routes.loginScreen);
            })

        ],
      ).appPaddingHr,
    );
  }

  Future<void> _onLogout(BuildContext context)async{
    await Popups.showWarning(context,
    title: AppStrings.logout.tr(),
    message: AppStrings.areYouSureToLogout.tr(),
    onConfirm: userCubit.logout,
    );
  }
}
