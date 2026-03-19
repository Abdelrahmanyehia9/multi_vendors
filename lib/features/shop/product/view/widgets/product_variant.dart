import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/circular_box.dart';

import '../../../../../../core/theme/app_colors.dart';


class ProductVariant<T> extends StatelessWidget {
  final List<T> variants ;
  final ValueNotifier<int> activeIndex ;
  const ProductVariant({super.key, required this.variants, required this.activeIndex}  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: activeIndex,
      builder: (context, value, child) {
        return Wrap(
          spacing: 6.w,
          runSpacing: 4.h,
          children: List.generate(variants.length, (i)=>AppClick(
              onTap: (){
                activeIndex.value = i;
              },
              child: _buildVariantItem(variants[i], context, isActive: value == i))),
        );
      }
    );
  }

  Widget _buildVariantItem(T variant,BuildContext context ,{bool isActive = false}){
    final Color surfaceLow = context.colors.surfaceContainerLow ;
    if(variant is Color){
      return Stack(
        children: [
          CircularBox(
            backgroundColor: variant,
            radius: 30,
            shadow: [
              BoxShadow(
                color: surfaceLow.withAppOpacity(0.5),
                blurRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],

          ),
          if(isActive)
          CircularBox(
            backgroundColor: Colors.black.withAppOpacity(0.3),
            radius: 30,
            child: const Icon(Icons.check, color: AppColors.white),

          ),
        ],
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border:isActive? null :  Border.all(color: surfaceLow),
        color: isActive ? AppColors.primary : Colors.transparent,
      ),
      child: Text(variant.toString(), style: TextStyles.labelSmall.copyWith(
        color: isActive ? AppColors.white : null,
      ),),
    ) ;
  }
}
