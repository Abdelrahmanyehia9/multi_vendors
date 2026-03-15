import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/circular_box.dart';
import 'package:multi_vendor/core/widgets/section_header.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../core/utils/testing.dart';

class HomeVendorsSection extends StatelessWidget {
  const HomeVendorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = 5;
    final maxItems = 6;
    final displayCount = items < maxItems ? items : maxItems;
    final reminder = items - displayCount + 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: "Vendors", hasAction: items <= maxItems, onActionTap: ()=>viewAll(context),),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            spacing: 8.w,
            children: List.generate(
              displayCount,
                  (index) {
                bool lastOne = items > maxItems && index == displayCount - 1;
                    return _vendor(
                lastOne,
                context,
                reminder: reminder,
              );
                  },
            ),
          ),
        ),
      ],
    );
  }

  Widget _vendor(bool lastOne,BuildContext context, {required int reminder}) => AppClick(
    onTap: ()=> context.pushNamed(Routes.vendor),
    child: CircularBox(
      radius: 52,
      child: !lastOne
          ? const AppCachedNetworkImage(Testing.vendor)
          : AppClick(
        onTap: ()=> viewAll(context),
            child: CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: Text(
            "+$reminder",
            style: TextStyles.captionLarge.copyWith(color: AppColors.white),
                  ),
                ),
          ),
    ),
  );
  void viewAll(BuildContext context) => context.pushNamed(Routes.vendors);
}


