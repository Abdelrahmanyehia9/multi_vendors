// import 'package:collection/collection.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:multi_vendor/core/theme/text_styles.dart';
// import 'package:multi_vendor/features/shop/product/view/widgets/product_info_section.dart';
//
// import '../../../../../../core/theme/app_colors.dart';
// import '../../../../../core/models/variant_model.dart';
// import '../../../../../core/widgets/product_variants.dart';
// import '../../mixin/product_variants_mixin.dart';
//
//
//
// class VariantsSection extends StatefulWidget {
//   final List<VariantModel>? variants;
//   final ValueNotifier<VariantModel?> selectedVariant ;
//   final bool showRemaining;
//   const VariantsSection({super.key, this.showRemaining = false, this.variants, required this.selectedVariant});
//
//   @override
//   State<VariantsSection> createState() => _VariantsSectionState();
// }
//
// class _VariantsSectionState extends State<VariantsSection>
//     with ProductVariantMixin {
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: selectedAttributesNotifier,
//       builder: (_, selectedAttrs, __) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         spacing: 8.h,
//         children:[
//           ...availableAttributes.entries
//               .mapIndexed(
//                 (i, item) => ProductInfoSection(
//               header: item.key,
//               customBody: ProductVariant.single(
//                 variants: item.value,
//                 availableVariants: availableValuesForKey(item.key),
//                 activeIndex: indexNotifierForKey(item.key)!,
//                 onDeselect: (_) => onDeselectAttribute(item.key),
//                 onSelect: (selected) => onSelectAttribute(item.key, selected),
//               ),
//             ),
//           ),
//           if(selectedVariant.value==null && widget.showRemaining)
//             Text("please select :${unselectedAttributes.join(" , ")}", style: TextStyles.bodySmall.copyWith(
//               color: AppColors.error
//             ))
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//
//
