import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/features/shop/product/data/model/products_response_model.dart';
import 'package:multi_vendor/features/shop/product/logic/products_all_filters_cubit.dart';
import 'package:multi_vendor/features/shop/product/logic/products_by_filters_cubit.dart';
import 'package:multi_vendor/features/vendors/data/model/vendor_details_model.dart';
import 'package:multi_vendor/features/vendors/logic/vendor_details_cubit.dart';
import 'package:multi_vendor/features/vendors/view/widgets/vendor_app_bar.dart';
import 'package:multi_vendor/features/vendors/view/widgets/vendor_info_card.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/shared/view/mixin/scroll_visibility.dart';
import 'package:multi_vendor/shared/data/models/vendor_model.dart';
import 'package:multi_vendor/shared/view/widgets/cards/product_card.dart';
import 'package:multi_vendor/shared/view/widgets/read_more_text.dart';
import 'package:multi_vendor/features/shop/product/data/model/products_filters_model.dart';
import 'package:multi_vendor/features/shop/product/view/widgets/filters/product_filters_action.dart';
import 'package:multi_vendor/features/shop/product/view/widgets/filters/products_filters_chips.dart';

class VendorDetailsScreen extends StatefulWidget {
  const VendorDetailsScreen({super.key});

  @override
  State<VendorDetailsScreen> createState() => _VendorDetailsScreenState();
}

class _VendorDetailsScreenState extends State<VendorDetailsScreen>
    with ScrollTitleVisibilityMixin {

    Future<void> _fetchProducts(VendorDetailsModel? v) async {
    final filters = ProductsFiltersModel(
      vendors: [VendorModel(id: v!.id, name: v.name, image: v.image)],
    );
    final filtersCubit = context.read<ProductsAllFiltersCubit>();
    filtersCubit..init(filters)..exclude([ProductsFilters.vendor]);
    context.read<ProductsByFiltersCubit>().getProductsInFilter(
      filters: filters,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseBlocConsumer<VendorDetailsCubit, VendorDetailsModel>(
        onSuccess: _fetchProducts,
        successBuilder: _buildContent,
        loadingBuilder: () => _buildContent(VendorDetailsModel.fake()),
      ),
    );
  }

  Widget _buildContent(VendorDetailsModel vendor) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        VendorAppBar(
          collapsed: showTitle,
          vendor: vendor,
          expandedHeight: titleThreshold,
        ),
       if(vendor.bio!=null)SliverToBoxAdapter(child: _buildBio(vendor.bio!.localized),),
        SliverToBoxAdapter(child: VendorInfoCard(vendor: vendor)),
        _productsHeader(),
        SliverToBoxAdapter(child: const ProductsFiltersChip().appPaddingAll),
        _productsList(),
      ],
    );
  }
  Widget _productsHeader() {
    return SliverToBoxAdapter(
      child: BaseBlocConsumer<ProductsByFiltersCubit, ProductResponseModel>(
        builder: (_) {
          final total = context
              .read<ProductsByFiltersCubit>()
              .state
              .data
              ?.pagination
              ?.total;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(AppStrings.products.tr(), style: TextStyles.bodyLarge),
                  if (total != null) ...[
                    const Gap(4),
                    Text("($total)", style: TextStyles.captionMedium),
                  ],
                ],
              ),
              const ProductFiltersAction(),
            ],
          ).appPaddingAll;
        },
      ),
    );
  }
  Widget _productsList() {
    return SliverToBoxAdapter(
      child: BaseBlocConsumer<ProductsByFiltersCubit, ProductResponseModel>(
        successBuilder: (res) =>
            ProductGrid(shrinkWrap: true, products: res.products),
        loadingBuilder: () => ProductGrid(
          shrinkWrap: true,
          products: ProductResponseModel.fake().products,
        ),
        emptyBuilder: AppStates.empty,
      ).appPaddingHr,
    );
  }
  Widget _buildBio(String bio){
      return Container(
        padding: EdgeInsets.all(16.r),
        margin: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: context.scaffoldBackground,
          boxShadow: [
            BoxShadow(
              color: context.colors.surfaceContainerLowest.withAppOpacity(0.4),
              blurRadius: Decorations.borderRadius24.r,
              offset: const Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(Decorations.borderRadius16.r),
          border: Border.all(color: context.colors.surfaceContainerLowest),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.bio.tr().toUpperCase(), style: TextStyles.labelMedium,),
            ReadMoreText(text:bio , maxLength: 60,style: TextStyles.captionMedium,)
          ],
        ),
      );
  }

  @override
  double get titleThreshold => 240;
}
