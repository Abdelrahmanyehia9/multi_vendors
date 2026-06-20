import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/features/main/profile/view/widgets/profile_list_tile.dart';
import 'package:multi_vendor/shared/data/models/user_model.dart';
import 'package:multi_vendor/shared/logic/user_preferences_cubit.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPreferencesCubit, UserPreferences>(
      bloc: userPreferencesCubit,
      builder: (context, state) {
        return ProfileListTile(
          icon: MvIcons.theme,
          title: AppStrings.theme.tr(),
          trailing: SegmentedButton<ThemeMode>(
              showSelectedIcon: false,
              style: SegmentedButton.styleFrom(
                animationDuration: const Duration(milliseconds: 200),
                backgroundColor: context.colors.surfaceContainerLowest,
                selectedBackgroundColor: context.colors.primary,
                selectedForegroundColor: AppColors.white,
                foregroundColor: context.colors.onSurface,
                side: BorderSide.none,
              ),
              onSelectionChanged: (selected)=>userPreferencesCubit.setThemeMode(selected.first),
              segments: const [
                ButtonSegment(
                  value: ThemeMode.light,
                  icon: Icon(MvIcons.light),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  icon: Icon(MvIcons.dark),

                ),
                ButtonSegment(
                  value: ThemeMode.system,
                  icon: Icon(MvIcons.mobile),

                )
              ],
              selected: {state.themeMode}
          )
        );
      },
    );
  }
}

