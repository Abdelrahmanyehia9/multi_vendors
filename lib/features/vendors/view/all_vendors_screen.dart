import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/vendors/data/model/vendor_details_model.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/features/main/category/logic/main_categories_cubit.dart';
import 'package:multi_vendor/features/main/category/data/model/category_model.dart';
import 'package:multi_vendor/features/vendors/data/model/vendor_model.dart';
import 'package:multi_vendor/shared/view/widgets/circular_box.dart';
import 'package:multi_vendor/shared/view/widgets/section_header.dart';
import 'package:multi_vendor/features/vendors/logic/vendors_by_category_cubit.dart';
import 'package:multi_vendor/features/vendors/view/mixin/all_vendors_screen_mixin.dart';
import 'package:multi_vendor/features/vendors/view/widgets/vendor_card.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';

class AllVendorsScreen extends StatefulWidget {
  const AllVendorsScreen({super.key});

  @override
  State<AllVendorsScreen> createState() => _AllVendorsScreenState();
}
class _AllVendorsScreenState extends State<AllVendorsScreen>  with AllVendorsScreenMixin{

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: AppStrings.vendors.tr()),
      body: Column(spacing: 12.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseBlocConsumer<MainCategoriesCubit, List<CategoryModel>>(
            onSuccess:(cat)=> onCategoriesSuccess(cat!),
            successBuilder: (categories) => _Categories(selectedTagIndex, categories),
            loadingBuilder: () => _Categories(
              selectedTagIndex,
              List.generate(5, (_) => CategoryModel.fake()),
            ),
          ),
          Expanded(
            child: BaseBlocConsumer<VendorsByCategoryCubit, List<VendorDetailsModel>>(
              loadingBuilder:()=> VendorsCardList(
                vendors: List.generate(10, (i) => VendorModel.fake()),
              ),
              successBuilder: (vendors) => VendorsCardList(vendors: vendors),
              failureBuilder: AppStates.error,
              emptyBuilder: AppStates.empty,
            ),
          ),
        ],
      ),
    );
  }
}

class _Categories extends StatelessWidget {
  final ValueNotifier<int>selectedTag ;
  final List<CategoryModel>categories;
  const _Categories(this.selectedTag, this.categories);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         SectionHeader(
          title: AppStrings.categories.tr(),
        ),
        ValueListenableBuilder<int>(
          valueListenable: selectedTag,
          builder: (_, value, __) => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            child: Row(
              spacing: 4.w,
              children: List.generate(
                categories.length,
                    (i) => AppClick(
                  onTap: () => selectedTag.value = i,
                  child: _categoryItem(selected: i == value, category: categories[i]),
                ),
              ),
            ).paddingVr(8),
          ),
        ),
      ],
    );
  }
  Widget _categoryItem({double width = 70, bool selected = false,required CategoryModel category}) {
    return SizedBox(
      width: width.w,
      child: Column(
        children: [
          CircularBox(
            radius: 65,
            borderColor: selected ? AppColors.primary : null,
            child:  AppCachedNetworkImage(category.img),
          ),
          Gap.tiny(),
          SizedBox(
            width: (width - 20).w,
            child: Text(
              category.name.localized,
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