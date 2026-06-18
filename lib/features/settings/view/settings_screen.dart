import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/types/type_def.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/overlays/bottom_sheets.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';

import 'package:multi_vendor/features/main/profile/view/widgets/profile_list_tile.dart';
import 'package:multi_vendor/features/settings/view/widget/language_selection.dart';
import 'package:multi_vendor/features/settings/view/widget/notification_switcher.dart';
import 'package:multi_vendor/features/settings/view/widget/theme_switcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});


  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {



  @override
  Widget build(BuildContext context) {
     List<ListTileData> list = [
      if (FeatureFlags.enableMultiLanguage)
        (AppStrings.language.tr(), MvIcons.translation, showToggleLanguage),
    ];
    return BaseScaffold(
      appBar: BaseAppBar(title: AppStrings.settings.tr(),),
      body: Column(
        spacing: 8.h,
        children: [
          ...List.generate(
            list.length,
                (index) => ProfileListTile(
              title:list[index].$1,
              icon: list[index].$2!,
              onTap:list[index].$3,
            ),
          ),
          const ThemeSwitcher(),
          const NotificationSwitcher(),


        ]
      ),
    );
  }

  void showToggleLanguage(BuildContext context)=>BottomSheets.show(context, child: const LanguageSelection() ) ;
}
