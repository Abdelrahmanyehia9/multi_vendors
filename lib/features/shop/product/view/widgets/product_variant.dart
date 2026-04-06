import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/circular_box.dart';
import 'package:multi_vendor/features/shop/product/view/widgets/product_info_section.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../core/models/variant_model.dart';
import '../../../mixin/product_variants_mixin.dart';



class VariantsSection extends StatefulWidget {
  final List<VariantModel>? variants;
  final ValueNotifier<VariantModel?> selectedVariant ;
  final bool showRemaining;
  const VariantsSection({super.key, this.showRemaining = false, this.variants, required this.selectedVariant});

  @override
  State<VariantsSection> createState() => _VariantsSectionState();
}

class _VariantsSectionState extends State<VariantsSection>
    with ProductVariantMixin {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedAttributesNotifier,
      builder: (_, selectedAttrs, __) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children:[
          ...availableAttributes.entries
              .mapIndexed(
                (i, item) => ProductInfoSection(
              header: item.key,
              customBody: _ProductVariant(
                variants: item.value,
                availableVariants: availableValuesForKey(item.key),
                activeIndex: indexNotifierForKey(item.key)!,
                onDeselect: (_) => onDeselectAttribute(item.key),
                onSelect: (selected) => onSelectAttribute(item.key, selected),
              ),
            ),
          ),
          if(selectedVariant.value==null && widget.showRemaining)
            Text("please select :${unselectedAttributes.join(" , ")}", style: TextStyles.bodySmall.copyWith(
              color: AppColors.error
            ))
        ], 
      ),
    );
  }
}






class _ProductVariant extends StatelessWidget {
  final List<VariantsAttributes> variants;
  final ValueNotifier<int> activeIndex;
  final List<VariantsAttributes>? availableVariants;
  final ValueChanged<VariantsAttributes>? onSelect;
  final ValueChanged<VariantsAttributes>? onDeselect;

  const _ProductVariant({
    this.availableVariants,
    this.onSelect,
    this.onDeselect ,
    required this.variants,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: activeIndex,
      builder: (context, value, child) {
        return Wrap(
          spacing: 6.w,
          runSpacing: 4.h,
          children: List.generate(
            variants.length,
                (i) {
              final attr = variants[i];
              final isAvailable = availableVariants?.any((a) => a.value == attr.value) ?? true;
              return AppClick(
                onTap: isAvailable ? () {
                  if(activeIndex.value == i){
                    activeIndex.value = -1;
                    onDeselect?.call(attr);
                  }else{
                    activeIndex.value = i;
                    onSelect?.call(attr);
                  }
                } : null,

                child: _buildVariantItem(
                  attr,
                  isAvailable,
                  context,
                  isActive: value == i,
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildVariantItem(
      VariantsAttributes variant,
      bool isAvailable,
      BuildContext context, {
        bool isActive = false,
      }) {
    final Color surfaceLow = context.colors.surfaceContainerLow;

    if (variant.type == VariantType.color) {
      return Opacity(
        opacity: isAvailable ? 1.0 : 0.3,
        child: Stack(
          children: [
            CircularBox(
              backgroundColor: ColorExtension.fromRgbString(variant.value),
              radius: 30,
              borderColor: isActive ? AppColors.primary : null,
              shadow: [
                BoxShadow(
                  color: context.colors.surfaceContainer.withAppOpacity(0.5),
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            if (isActive )CircularBox(
                backgroundColor: Colors.black.withAppOpacity(0.2),
                radius: 30,
                child:  Icon(
                size: 20.sp,
                Icons.check, color: AppColors.white),
              ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: isActive ? null : Border.all(
          color: isAvailable ? surfaceLow : surfaceLow.withAppOpacity(0.3),
        ),
        color: isActive ? AppColors.primary : Colors.transparent,
      ),
      child: Text(
        variant.value,
        style: TextStyles.labelSmall.copyWith(
          color: isActive
              ? AppColors.white
              : isAvailable
              ? null
              : surfaceLow,
          decoration: isAvailable ? null : TextDecoration.lineThrough,
          decorationThickness: 2,
          decorationColor: surfaceLow,
        ),
      ),
    );
  }
}