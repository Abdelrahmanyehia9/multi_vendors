import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/gap.dart';
import '../../../../../core/widgets/section_header.dart';

class SearchHistory extends StatelessWidget {
  const SearchHistory({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        spacing: 16.h,
        children: [
          const SectionHeader(
            title: "Search History",
            hasAction: true,
            customAction: AppIconButton(icon: Icons.delete),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 40,
              separatorBuilder: (context, index) => Gap.large(),
              itemBuilder: (context, index) => _buildHistoryItem(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text("T-shirt", style: TextStyles.captionLarge),
      Icon(Icons.close, size: 16.sp),
    ],
  );
}
