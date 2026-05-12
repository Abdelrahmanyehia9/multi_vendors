import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/features/shop/product/data/model/products_filters_model.dart';
import 'package:multi_vendor/features/shop/product/view/all_products_screen.dart';
import 'package:multi_vendor/core/routes/routes.dart';
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

class _HomeShopByCategoriesState extends State<HomeShopByCategories> {
  final ValueNotifier<int> _selectedItem = ValueNotifier<int>(-1);
  List<CategoryModel> _categories = [];

  void _onSelectionChanged() {
    if (_selectedItem.value < 0 || _selectedItem.value >= _categories.length) return;
    context.read<HomeProductBySubCategoryCubit>().getProductByCategory(
      _categories[_selectedItem.value].id!,
    );
  }

  void _onCategoriesGetSuccess(List<CategoryModel>? data) {
    if (data == null || data.isEmpty) return;
    _selectedItem.removeListener(_onSelectionChanged);
    _categories = data;
    _selectedItem.value = 0;
    _onSelectionChanged();
    _selectedItem.addListener(_onSelectionChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BaseBlocConsumer<SubCategoriesCubit, List<CategoryModel>>(
          onSuccess: _onCategoriesGetSuccess,
          successBuilder: (categories) => _Categories(
            selectedItem: _selectedItem,
            categories: categories,
          ),
          loadingBuilder: () => _Categories(
            selectedItem: ValueNotifier(-1),
            categories: List.generate(10, (_) => CategoryModel.fake()),
          ),
        ),
        Gap.medium(),
        BaseBlocConsumer<HomeProductBySubCategoryCubit, List<ProductModel>>(
          successBuilder: (p) => ProductGrid(shrinkWrap: true, products: p),
          loadingBuilder: () => ProductGrid(
            shrinkWrap: true,
            products: List.generate(
              4,
                  (_) => const ProductModel(name: {}, price: null),
            ),
          ),
          emptyBuilder: AppStates.empty,
          failureBuilder: AppStates.error,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _selectedItem.removeListener(_onSelectionChanged);
    _selectedItem.dispose();
    super.dispose();
  }
}

class _Categories extends StatelessWidget {
  final ValueNotifier<int> selectedItem;
  final List<CategoryModel> categories;

  const _Categories({required this.selectedItem, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
          title: AppStrings.categories.tr(),
          hasAction: true,
          onActionTap: () {
            final index = selectedItem.value;
            if (index < 0 || index >= categories.length) return;
            context.pushNamed(
              Routes.products,
              arguments: ProductsScreenArgs(
                initialFilters: ProductsFiltersModel(
                  categories: [categories[index]],
                ),
              ),
            );
          },
        ),
        ValueListenableBuilder(
          valueListenable: selectedItem,
          builder: (context, value, child) {
            return SizedBox(
              height: 42.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                clipBehavior: Clip.none,
                itemCount: categories.length,
                separatorBuilder: (_, __) => SizedBox(width: 12.w),
                itemBuilder: (_, i) => AppClick(
                  onTap: () => selectedItem.value = i,
                  child: AppChip(
                    borderRadius: Decorations.borderRadius12.r,
                    text: categories[i].name.localized,
                    selected: value == i,
                    child: Row(
                      spacing: 6.w,
                      children: [
                        if (value == i && !categories[i].img.isNullOrEmpty)
                          CircularBox(
                            radius: 30,
                            child: AppCachedNetworkImage(
                              fit: BoxFit.fill,
                              categories[i].img,
                            ),
                          ),
                        Text(
                          categories[i].name.localized,
                          style: TextStyles.bodySmall.copyWith(
                            color: value == i ? AppColors.white : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}