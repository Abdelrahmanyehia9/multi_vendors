import 'package:flutter/material.dart';
import 'package:multi_vendor/core/types/type_def.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';

import '../../main/profile/view/widgets/profile_list_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  static final List<ListTileData> _list = [
    if (FeatureFlags.enableMultiLanguage)
      ("Languange", Icons.language, null),
  ];
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: "Settings",),
      body: Column(
        children: List.generate(
          _list.length,
          (index) => ProfileListTile(
            title: _list[index].$1,
            icon: _list[index].$2!,
            onTap: _list[index].$3,
          ),
        ),
      ),
    );
  }
}
