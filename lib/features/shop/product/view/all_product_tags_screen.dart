import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/core/widgets/app_text_field.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import '../../../../../core/widgets/cards/product_tag_tile.dart';
import '../../../../../core/widgets/scaffold/base_appbar.dart';

class AllProductTagsScreen extends StatelessWidget {
  const AllProductTagsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: AppConstants.tagsString),
      body: Column(
        spacing: 12.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchField(),
          const Expanded(
            child: ProductTagTileList()
          ),
        ],
      ).appPaddingHr,
    );
  }

  Widget _buildSearchField() => const AppTextField(hintText: "Search ... ", prefix: Icon(Icons.search));
}
