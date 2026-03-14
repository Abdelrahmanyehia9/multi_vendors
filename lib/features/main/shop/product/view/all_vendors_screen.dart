import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/testing.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/circular_box.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/cards/vendor_card.dart';
import '../../../../../core/widgets/scaffold/base_appbar.dart';
import '../../../../../core/widgets/section_header.dart';

class AllVendorsScreen extends StatefulWidget {
  const AllVendorsScreen({super.key});

  @override
  State<AllVendorsScreen> createState() => _AllVendorsScreenState();
}
class _AllVendorsScreenState extends State<AllVendorsScreen> {
  final selectedTagIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: "Vendors"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Tags(selectedTagIndex),
          const Expanded(
              child:VendorsCardList()
          )
        ],
      ).appPaddingHr,
    );
  }
  @override
  void dispose() {
    selectedTagIndex.dispose();
    super.dispose();
  }
}

class _Tags extends StatelessWidget {
  final ValueNotifier<int>selectedTag ;
  const _Tags(this.selectedTag);

  @override
  Widget build(BuildContext context) {
    const int items = 10;
    const int maxItems = 6;
    final displayedItems = min(items, maxItems);
    final bool hasAction = items > maxItems;
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: "Categories",
          hasAction: hasAction,
          onActionTap: (){},
        ),
        ValueListenableBuilder<int>(
          valueListenable: selectedTag,
          builder: (_, value, __) => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            child: Row(
              spacing: 4.w,
              children: List.generate(
                displayedItems,
                    (i) => AppClick(
                  onTap: () => selectedTag.value = i,
                  child: _categoryItem(selected: i == value),
                ),
              ),
            ).paddingVr(8),
          ),
        ),
      ],
    );
  }
  Widget _categoryItem({double width = 70, bool selected = false}) {
    return SizedBox(
      width: width.w,
      child: Column(
        children: [
          CircularBox(
            radius: 65,
            borderColor: selected ? AppColors.primary : null,
            child: const AppCachedNetworkImage(Testing.girlModel),
          ),
          Gap.tiny(),
          SizedBox(
            width: (width - 20).w,
            child: Text(
              "Woman Wear",
              textAlign: TextAlign.center,
              style: TextStyles.bodySmall.copyWith(
                color: selected ? AppColors.primary : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
