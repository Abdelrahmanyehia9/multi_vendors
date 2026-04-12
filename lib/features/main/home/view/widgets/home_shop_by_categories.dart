import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/models/base_category_model.dart';
import 'package:multi_vendor/core/widgets/app_chip.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/cards/product_card.dart';
import 'package:multi_vendor/features/main/home/logic/home_cateogries_logic.dart';
import 'package:multi_vendor/features/shop/product/data/model/products_filters_model.dart';
import '../../../../../core/models/product_model.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/widgets/app_states.dart';
import '../../../../../core/widgets/gap.dart';
import '../../../../../core/widgets/section_header.dart';
import '../../logic/home_product_by_category_cubit.dart';

class HomeShopByCategories extends StatefulWidget {
  const HomeShopByCategories({super.key});

  @override
  State<HomeShopByCategories> createState() => _HomeShopByCategoriesState();
}

class _HomeShopByCategoriesState extends State<HomeShopByCategories> {
  late final ValueNotifier<int> _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BaseBlocConsumer<HomeCategoriesCubit, List<CategoryModel>>(
          onSuccess: (i) {
            _selectedItem = ValueNotifier<int>(0);
            context.read<HomeProductByCategoryCubit>().getProductByCategory(
              i![_selectedItem.value].id!,
            );
            _selectedItem.addListener(() {
              context.read<HomeProductByCategoryCubit>().getProductByCategory(
                i[_selectedItem.value].id!,
              );
            });
          },
          successBuilder: (categories) =>
              _Categories(selectedItem: _selectedItem, categories: categories),
          loadingBuilder: () => _Categories(
            selectedItem: ValueNotifier(-1),
            categories: List.generate(10, (_) => const CategoryModel(name: '')),
          ),
        ),
        Gap.medium(),
        BaseBlocConsumer<HomeProductByCategoryCubit, List<ProductModel>>(
          successBuilder: (p) => ProductGrid(shrinkWrap: true, products: p),
          loadingBuilder: () => ProductGrid(
            shrinkWrap: true,
            products: List.generate(
              4,
              (_) => const ProductModel(name: '', price: null),
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
          title: "Categories",
          hasAction: true,
          onActionTap: () => context.pushNamed(
            Routes.products,
            arguments: ProductsFiltersModel(
              categories: [categories[selectedItem.value]],
            ),
          ),
        ),
        ValueListenableBuilder(
          valueListenable: selectedItem,
          builder: (context, value, child) {
            return SizedBox(
              height: 30.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                clipBehavior: Clip.none,
                itemBuilder: (_, i) => AppClick(
                  onTap: () {
                    selectedItem.value = i;
                  },
                  child: AppChip(
                    text: categories[i].name,
                    selected: value == i,
                  ),
                ),
                separatorBuilder: (_, _) => SizedBox(width: 12.w),
                itemCount: categories.length,
              ),
            );
          },
        ),
      ],
    );
  }
}
