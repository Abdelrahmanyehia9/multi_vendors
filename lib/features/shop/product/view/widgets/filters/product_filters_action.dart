import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/core/widgets/overlays/bottom_sheets.dart';
import 'package:multi_vendor/features/shop/product/data/model/products_filters_model.dart';
import 'package:multi_vendor/features/shop/product/logic/products_all_filters_cubit.dart';
import 'package:multi_vendor/features/shop/product/view/widgets/filters/product_filters_sheet.dart';

import '../../../../../../core/mixin/show_menu_mixin.dart';
import '../../../../../../core/widgets/app_button.dart';
import '../../../../../../core/widgets/gap.dart';
import '../../../logic/products_by_filters_cubit.dart';

class ProductFiltersAction extends StatefulWidget {
  final double gap;
  const ProductFiltersAction({super.key, this.gap = 4});

  @override
  State<ProductFiltersAction> createState() => _ProductFiltersActionState();
}

class _ProductFiltersActionState extends State<ProductFiltersAction>
    with ShowMenuMixin<ProductSortBy> {

  final _sortKey = GlobalKey();
  ProductsFiltersModel? _filters;

  List<ProductSortBy> get _sortOptions =>
      ProductSortByType.values.expand((t) => [
        ProductSortBy(type: t),
        ProductSortBy(type: t, asc: false),
      ]).toList();

  void _applyFilters() {
    if (_filters == null) return;
    final allCubit = context.read<ProductsAllFiltersCubit>();
    final productsCubit = context.read<ProductsByFiltersCubit>();

    allCubit.setFilters(_filters!);
    if (context.mounted) {
      productsCubit.getProductsInFilter(filters: _filters!);
    }
  }

  @override
  void initState() {
    _filters = context.read<ProductsAllFiltersCubit>().selectedFilters;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!FeatureFlags.enableProductFilters) return const SizedBox.shrink();

    return Row(
      children: [
        AppIconButton(
          icon: Icons.filter_alt,
          onTap: () async {
            final result = await BottomSheets.show<ProductsFiltersModel>(
              context,
              child: BlocProvider.value(
                value: context.read<ProductsAllFiltersCubit>(),
                child: const ProductFiltersSheet(),
              ),
            );

            if (result != null) {
              _filters = result;
              _applyFilters();
            }
          },
        ),
        Gap(widget.gap),
        AppIconButton(
          key: _sortKey,
          icon: Icons.sort,
          onTap: () => showPopupMenu(
            context: context,
            key: _sortKey,
            items: _sortOptions
                .map((e) => PopupMenuItem(
              value: e,
              child: Text(e.type.toText(e.asc)),
            ))
                .toList(),
            onSelected: (value) {
              _filters = (_filters ?? const ProductsFiltersModel())
                  .copyWith(sortBy: value);
              _applyFilters();
            },
          ),
        ),
      ],
    );
  }
}