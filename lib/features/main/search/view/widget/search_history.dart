import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
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
  final void Function(String)? onTapOnItem ;

  const SearchHistory({super.key,
    this.onRemoveAll,
    this.onRemoveItem,
    this.onTapOnItem,
    required this.searchHistory});

  @override
  Widget build(BuildContext context) {
    if (searchHistory.isEmpty) {
      return  Expanded(child: AppStates.empty(
      customIcon: MvIcons.search,
      message: AppStrings.noSearchHistory,
    ));
    }
    return Expanded(
      child: Column(
        spacing: 16.h,
        children: [
          if (searchHistory.isNotEmpty)
             SectionHeader(
              title: AppStrings.searchHistory.tr(),
              hasAction: true,
              customAction:  AppDeleteButton(onTap: onRemoveAll)
            ),
          Expanded(
            child: ListView.separated(
              itemCount: searchHistory.length,
              separatorBuilder: (_, index) => Gap.large(),
              itemBuilder: (_, index) =>
                  AppClick(
                      onTap: ()=>onTapOnItem?.call(searchHistory[index]),
                      child: _buildHistoryItem(searchHistory[index] , index)),
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
          child: Icon(MvIcons.close, size: 16.sp)),
    ],
  );
}
