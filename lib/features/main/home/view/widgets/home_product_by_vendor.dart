library;

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/features/main/home/logic/home_product_by_vendor_cubit.dart';
import 'package:multi_vendor/features/shop/product/data/model/products_filters_model.dart';
import 'package:multi_vendor/features/shop/product/view/all_products_screen.dart';
import 'package:multi_vendor/shared/data/models/product_model.dart';
import 'package:multi_vendor/shared/data/models/vendor_model.dart';
import 'package:multi_vendor/shared/view/layouts/product_list.dart';
import 'package:multi_vendor/shared/view/widgets/cards/product_card.dart';
import 'package:multi_vendor/shared/view/widgets/verified_chip.dart';

part 'productByVendor/vendor_info.dart';
part 'productByVendor/adv_rippon.dart';
part 'productByVendor/vendor_thumb.dart';
class HomeProductByVendor extends StatelessWidget {
  const HomeProductByVendor({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<HomeProductByVendorCubit, List<ProductModel>>(
      successBuilder: (p) => _BuildProductsByVendor(products: p),
      loadingBuilder: () => _BuildProductsByVendor(
        products: List.generate(8, (i) => ProductModel.fake()),
      ),
    );
  }
}

class _BuildProductsByVendor extends StatelessWidget {
  final List<ProductModel> products;

  const _BuildProductsByVendor({required this.products});

  @override
  Widget build(BuildContext context) {
    final VendorModel vendor = products.first.vendor!;
    final Color color = vendor.color ?? AppColors.black;
    return Stack(
      clipBehavior: Clip.none,
      children: [
           DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [color.darken(0.05), color, color.withAppOpacity(0.7),color.withAppOpacity(0.3), Colors.transparent],
            ),
          ),
          child: Column(
            children: [
              _VendorInfo(vendor),
              Align(
                alignment: AlignmentGeometry.centerEnd,
                child: AppClick(
                  onTap: () => context.pushNamed(
                    Routes.products,
                    arguments: ProductsScreenArgs(
                      initialFilters: ProductsFiltersModel(vendors: [vendor]),
                    ),
                  ),
                  child: Text(
                    AppStrings.viewAll.tr(),
                    style: TextStyles.bodySmall.copyWith(color: AppColors.white),
                  ),

                ),
              ).appPaddingHr,
              10.verticalSpace,
              _productList(products),
            ],
          ),
        ),
          const _AdvRibbon(),
        Positioned(
            top: -12.h,
            child: _VendorThumb(vendor).paddingHr(8)),

      ],
    );
  }

  Widget _productList(List<ProductModel> products) => SizedBox(
    height: ProductCard.smallSize.height.h,
    child: ProductList(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      spacing: 8,
      clipBehavior: Clip.hardEdge,
      shrinkWrap: false,
      showVendor: false,
      products: products,
    ),
  );
}

