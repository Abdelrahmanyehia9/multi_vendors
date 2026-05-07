import 'package:flutter/material.dart';
import 'package:multi_vendor/core/types/type_def.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/overlays/bottom_sheets.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';

import 'package:multi_vendor/features/main/profile/view/widgets/profile_list_tile.dart';
import 'package:multi_vendor/features/settings/view/widget/language_selection.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});


  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final List<ListTileData> _list ;


  @override
  void initState() {
    _list = [
      if (FeatureFlags.enableMultiLanguage)
        ("Languange", MvIcons.translation, showToggleLanguage),
    ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: "Settings",),
      body: Column(
        children: List.generate(
          _list.length,
          (index) => ProfileListTile(
            title:_list[index].$1,
            icon: _list[index].$2!,
            onTap:_list[index].$3,
          ),
        ),
      ),
    );
  }

  void showToggleLanguage(BuildContext context)=>BottomSheets.show(context, child: const LanguageSelection() ) ;
}
