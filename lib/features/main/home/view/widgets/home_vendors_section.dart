import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/circular_box.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_section_header.dart';

import '../../../../../core/utils/testing.dart';

class HomeVendorsSection extends StatelessWidget {
  const HomeVendorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = 12;
    final maxItems = 8;
    return Column(
      children: [
        const HomeSectionHeader(title: "Vendors", hasAction: false,),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            spacing: 12.w,
            children: List.generate(maxItems, (index) => _vendor(index == maxItems - 1, reminder: items - index)),
          ),
        ),
      ],
    );
  }

  Widget _vendor(bool lastOne, {required int reminder}) =>
      CircularBox(
        radius: 56,
        child: !lastOne ? const AppCachedNetworkImage(Testing.vendor,) : CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Text("+$reminder", style: TextStyles.captionLarge.copyWith(color: AppColors.white),),
        ),
      );
}
