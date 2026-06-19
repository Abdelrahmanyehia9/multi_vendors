import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/features/main/main_layout_cubit.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/features/main/category/data/model/category_model.dart';
import 'package:multi_vendor/shared/data/models/product_model.dart';
import 'package:multi_vendor/features/main/category/logic/sub_categories_cubit.dart';
import 'package:multi_vendor/shared/view/layouts/product_grid.dart';
import 'package:multi_vendor/shared/view/widgets/app_chip.dart';
import 'package:multi_vendor/shared/view/widgets/circular_box.dart';
import 'package:multi_vendor/shared/view/widgets/section_header.dart';
import 'package:multi_vendor/features/main/home/logic/home_product_by_sub_category_cubit.dart';

class HomeShopByCategories extends StatefulWidget {
  const HomeShopByCategories({super.key});

  @override
  State<HomeShopByCategories> createState() => _HomeShopByCategoriesState();
}

class _HomeShopByCategoriesState extends State<HomeShopByCategories>  with AutomaticKeepAliveClientMixin {
  final _selected = ValueNotifier<CategoryModel?>(null);

  @override
  void initState() {
    super.initState();
    _selected.addListener(_onChanged);
  }
  void _onChanged() {
    final id = _selected.value?.id;
    if (id == null) return;
    context.read<HomeProductBySubCategoryCubit>().getProductByCategory(id);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        BaseBlocConsumer<SubCategoriesCubit, List<CategoryModel>>(
          onSuccess: (cat) => _selected.value = cat?.first,
          successBuilder: (cats) => _Categories(selected: _selected, categories: cats),
          loadingBuilder: () => _Categories(
            selected: ValueNotifier(null),
            categories: List.generate(10, (_) => CategoryModel.fake()),
          ),
        ),
        Gap.medium(),
        BaseBlocConsumer<HomeProductBySubCategoryCubit, List<ProductModel>>(
          successBuilder: (p) => ProductGrid(shrinkWrap: true, products: p),
          loadingBuilder: () => ProductGrid(
            shrinkWrap: true,
            products: List.generate(4, (_) =>  ProductModel.fake()),
          ),
          emptyBuilder: AppStates.empty,
          failureBuilder: AppStates.error,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _selected.removeListener(_onChanged);
    _selected.dispose();
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _Categories extends StatelessWidget {
  final ValueNotifier<CategoryModel?> selected;
  final List<CategoryModel> categories;

  const _Categories({required this.selected, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
          title: AppStrings.categories.tr(),
          hasAction: true,
          onActionTap: () => context.read<MainLayoutCubit>().changePage(1)
        ),
        ValueListenableBuilder(
          valueListenable: selected,
          builder: (context, value, _) => SizedBox(
            height: 42.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              clipBehavior: Clip.none,
              itemCount: categories.length,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemBuilder: (_, i) {
                final cat = categories[i];
                final isSelected = value == cat;
                return AppClick(
                  onTap: () => selected.value = cat,
                  child: AppChip(
                    borderRadius: Decorations.borderRadius12.r,
                    text: cat.name.localized,
                    selected: isSelected,
                    child: Row(
                      spacing: 6.w,
                      children: [
                        if (isSelected && !cat.img.isNullOrEmpty)
                          CircularBox(
                            radius: 30,
                            child: AppCachedNetworkImage(fit: BoxFit.fill, cat.img),
                          ),
                        Text(
                          cat.name.localized,
                          style: TextStyles.bodySmall.copyWith(
                            color: isSelected ? AppColors.white : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}