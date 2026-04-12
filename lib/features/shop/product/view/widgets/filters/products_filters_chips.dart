import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/cubit/base_bloc_consumer.dart';
import '../../../../../../core/widgets/app_chip.dart';
import '../../../data/model/products_filters_model.dart';
import '../../../logic/products_all_filters_cubit.dart';

class ProductsFiltersChip extends StatelessWidget {
  const ProductsFiltersChip({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductsAllFiltersCubit>();
    return BaseBlocConsumer<ProductsAllFiltersCubit, ProductsFiltersModel>(
      builder: (s){
        if(cubit.selectedFilters==null) return const SizedBox.shrink() ;
        return _buildFilterChips(cubit.selectedFilters!.toChips);
      },
    ) ;
  }

  Widget _buildFilterChips(List<String> filters)=> Wrap(
    spacing: 4.h,
    children: List.generate(filters.length, (i) =>  AppChip(text: filters[i].toUpperCase(), selected: true,)),
  );

}
