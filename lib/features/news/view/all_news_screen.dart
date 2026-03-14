import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/widgets/cards/news_card.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/scaffold/base_appbar.dart';
import '../../../core/widgets/scaffold/base_scaffold.dart';

class AllNewsScreen extends StatelessWidget {
  const AllNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title:"News"),
      body: Column(
        spacing: 16.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchField(),
          const Expanded(
            child: NewsList(
            ),
          ),
        ],
      ).appPaddingHr,
    );
  }

  Widget _buildSearchField() => const AppTextField(hintText: "Search ... ", prefix: Icon(Icons.search));
}
