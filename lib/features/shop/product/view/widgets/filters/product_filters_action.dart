import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/overlays/bottom_sheets.dart';
import 'package:multi_vendor/features/shop/product/data/model/products_filters_model.dart';
import 'package:multi_vendor/features/shop/product/logic/products_all_filters_cubit.dart';
import 'package:multi_vendor/features/shop/product/view/widgets/filters/product_filters_sheet.dart';
import 'package:multi_vendor/core/widgets/buttons/app_icon_button.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/shared/data/models/extension/products_filters.dart';
import 'package:multi_vendor/shared/view/mixin/show_menu_mixin.dart';
import 'package:multi_vendor/features/shop/product/data/model/product_sort_by.dart';
import 'package:multi_vendor/features/shop/product/logic/products_by_filters_cubit.dart';

class ProductFiltersAction extends StatefulWidget {
  final double gap;
  const ProductFiltersAction({super.key, this.gap = 4});

  @override
  State<ProductFiltersAction> createState() => _ProductFiltersActionState();
}

class _ProductFiltersActionState extends State<ProductFiltersAction>
    with ShowMenuMixin<ProductSortBy> {
  final _sortKey = GlobalKey();

  List<ProductSortBy> get _sortOptions => ProductSortByType.values
      .expand((t) => [ProductSortBy(type: t), ProductSortBy(type: t, asc: false)])
      .toList();

  void _applyFilters(ProductsFiltersModel filters) {
    context.read<ProductsAllFiltersCubit>().setFilters(filters);
    context.read<ProductsByFiltersCubit>().getProductsInFilter(filters: filters);
  }
  Future<void> _openFiltersSheet() async {
    final result = await BottomSheets.show<ProductsFiltersModel>(
      context,
      child: BlocProvider.value(
        value: context.read<ProductsAllFiltersCubit>(),
        child: const ProductFiltersSheet(),
      ),
    );
    if (result != null) _applyFilters(result);
  }
  void _openSortMenu(ProductsFiltersModel? currentFilters) {
    showPopupMenu(
      context: context,
      key: _sortKey,
      items: _sortOptions
          .map((e) => PopupMenuItem(
        value: e,
        child: Text(e.type.toText(e.asc)),
      ))
          .toList(),
      onSelected: (value) => _applyFilters(
        (currentFilters ?? const ProductsFiltersModel()).copyWith(sortBy: value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!FeatureFlags.enableProductFilters) return const SizedBox.shrink();
    return BaseBlocConsumer<ProductsAllFiltersCubit, ProductsFiltersModel>(
      builder: (state) {
        final filters = context.read<ProductsAllFiltersCubit>().selectedFilters;
        final hasFilters = !(filters?.withoutEXCLUDES(context.read<ProductsAllFiltersCubit>().excludes).isEmptyFilters ?? true);
        final hasSort = filters?.sortBy != null;
        return Row(
          children: [
            AppIconButton(
              backGroundColor: hasFilters ? AppColors.primary : null,
              iconColor: hasFilters ? AppColors.white : null,
              icon: MvIcons.filter,
              onTap: _openFiltersSheet,
            ),
            Gap(widget.gap),
            AppIconButton(
              key: _sortKey,
              backGroundColor: hasSort ? AppColors.primary : null,
              iconColor: hasSort ? AppColors.white : null,
              icon: MvIcons.sort,
              onTap: () => _openSortMenu(filters),
            ),
          ],
        );
      },
    );
  }
}