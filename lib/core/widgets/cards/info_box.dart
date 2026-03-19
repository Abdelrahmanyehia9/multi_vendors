import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/types/type_def.dart';

import '../gap.dart';

class InfoBox extends StatelessWidget {
  final List<TitleAndSubtitle> items ;
  final Widget? bottom ;
  final Widget? header ;
  final Widget? title ;
  const InfoBox({super.key,this.title ,this.header, required this.items, this.bottom});

  @override
  Widget build(BuildContext context) {
    if(title!=null){
      return Column(
        spacing: 4.h,
        children: [
          title!,
          _buildInfoBox(context)
        ],
      );
    }
    return _buildInfoBox(context);
  }

  Widget _buildInfoBox(BuildContext context)=>Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Decorations.borderRadius16.r),
      border: Border.all(color: context.colors.surfaceContainer) ,

    ),
    child: Column(
        spacing: 8.h,
        children: [
          Gap.small(),
          if(header != null) header!,
          ...List.generate(items.length, (i)=>Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(items[i].$1),
              if(!items[i].$2.isNullOrEmpty)
                Text(items[i].$2!),
            ],
          )),
          if(bottom != null) bottom!.paddingVr(4),
        ]

    ),
  );
}
