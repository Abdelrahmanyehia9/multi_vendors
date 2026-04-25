import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/core/widgets/section_header.dart';
import 'package:multi_vendor/features/shop/product/data/model/products_filters_model.dart';
import 'package:multi_vendor/features/shop/product/view/widgets/filters/product_filters_action.dart';
import 'package:multi_vendor/features/shop/product/view/widgets/filters/products_filters_chips.dart';
import '../../../../../core/widgets/cards/product_card.dart';
import '../../../../../core/widgets/scaffold/base_appbar.dart';
import '../data/model/products_response_model.dart';
import '../logic/products_all_filters_cubit.dart';
import '../logic/products_by_filters_cubit.dart';
class ProductsScreenArgs{
  final ProductsFiltersModel? initialFilters ;
  final List<ProductsFilters>? exclude;
  const ProductsScreenArgs({this.initialFilters , this.exclude});
}

class AllProductsScreen extends StatelessWidget {
  final  ProductsScreenArgs? args ;
  const AllProductsScreen({super.key,this.args });

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: "Shop",
        actions:const [
          ProductFiltersAction(),
        ],
      ),
      body: Column(
        spacing: 12.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductsFiltersChip(
            onFiltersGetSuccess: (){
              context.read<ProductsByFiltersCubit>().getProductsInFilter(
                filters: args?.initialFilters,
              );
            },
          ),
          Expanded(
            child: BaseBlocConsumer<ProductsByFiltersCubit, ProductResponseModel>(
              successBuilder:_buildProducts,
              failureBuilder: AppStates.error,
              emptyBuilder: AppStates.empty,
              loadingBuilder: ()=> _buildProducts(ProductResponseModel.fake()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProducts(ProductResponseModel model)=>Column(
    spacing: 12.h,
    children: [
      if(model.pagination?.total!=null)
      SectionHeader(title: "Total Products (${model.pagination!.total}) ", headerStyle: TextStyles.captionMedium,),
      Expanded(
        child: ProductGrid(
          products: model.products,
        ),
      )
    ],
  );
}


