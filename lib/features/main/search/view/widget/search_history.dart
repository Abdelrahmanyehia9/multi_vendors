import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/core/widgets/buttons/app_delete_button.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/shared/view/widgets/section_header.dart';

class SearchHistory extends StatelessWidget {
  final List<String> searchHistory;
  final void Function(int)? onRemoveItem ;
  final void Function()? onRemoveAll ;

  const SearchHistory({super.key,
    this.onRemoveAll,
    this.onRemoveItem,
    required this.searchHistory});

  @override
  Widget build(BuildContext context) {
    if (searchHistory.isEmpty) {
      return  Expanded(child: AppStates.empty(
      customIcon: Icons.search,
      message: "No search history",
    ));
    }
    return Expanded(
      child: Column(
        spacing: 16.h,
        children: [
          if (searchHistory.isNotEmpty)
             SectionHeader(
              title: "Search History",
              hasAction: true,
              customAction:  AppDeleteButton(onTap: onRemoveAll)
            ),
          Expanded(
            child: ListView.separated(
              itemCount: searchHistory.length,
              separatorBuilder: (_, index) => Gap.large(),
              itemBuilder: (_, index) =>
                  _buildHistoryItem(searchHistory[index] , index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String item, int index) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(item, style: TextStyles.captionLarge),
      AppClick(
          onTap: () => onRemoveItem?.call(index),
          child: Icon(Icons.close, size: 16.sp)),
    ],
  );
}
