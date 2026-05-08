import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/features/main/profile/view/widgets/profile_list_tile.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {

    return ProfileListTile(
        icon: MvIcons.theme,
        title: AppStrings.theme.tr(),
      trailing: Switch(
        value: context.isDark,
         onChanged: (_)=>userPreferencesCubit.toggleTheme(),
        thumbColor: const WidgetStatePropertyAll(AppColors.primary),
        activeTrackColor: context.colors.surfaceContainerLowest,
        inactiveTrackColor: context.colors.surfaceContainerLowest,
        thumbIcon: thumbIcon(),
        ),
    );
  }

  WidgetStateProperty<Icon?>thumbIcon()=>WidgetStateProperty.resolveWith<Icon>((states) {
    if (states.contains(WidgetState.selected)) {
      return const Icon(MvIcons.light, color: AppColors.white,);
    }
    return const Icon(MvIcons.dark , color: AppColors.white,);
  });
}
