import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/models/extension/products_filters.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/widgets/buttons/app_delete_button.dart';
import 'package:multi_vendor/features/shop/product/logic/products_by_filters_cubit.dart';

import '../../../../../../core/cubit/base_bloc_consumer.dart';
import '../../../../../../core/widgets/app_chip.dart';
import '../../../data/model/products_filters_model.dart';
import '../../../logic/products_all_filters_cubit.dart';

class ProductsFiltersChip extends StatelessWidget {
  const ProductsFiltersChip({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductsAllFiltersCubit>() ;
    return BaseBlocConsumer<ProductsAllFiltersCubit, ProductsFiltersModel>(
      onSuccess:(_){
        context.read<ProductsByFiltersCubit>().getProductsInFilter(
          filters: cubit.selectedFilters,
        );
      },
      builder: (s) {
        return _buildFilterChips(cubit);
      },
    );
  }
  Widget _buildFilterChips(ProductsAllFiltersCubit cubit) {
    if (cubit.selectedFilters == null) return const SizedBox.shrink();
    final filters = cubit.selectedFilters!.toChips(cubit.excludes);
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4.h,
      children: [
        ...List.generate(
          filters.length,
          (i) => AppChip(text: filters[i].toUpperCase(), selected: true),
        ),
        if (filters.isNotEmpty)
          AppDeleteButton(
            onTap: cubit.clearFilters,
            backGroundColor: AppColors.error,
            iconColor: AppColors.white,
          )
      ],
    );
  }
}
