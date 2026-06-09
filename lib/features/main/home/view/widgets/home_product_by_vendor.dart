import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/features/main/home/logic/home_product_by_vendor_cubit.dart';
import 'package:multi_vendor/features/shop/product/data/model/products_filters_model.dart';
import 'package:multi_vendor/features/shop/product/view/all_products_screen.dart';
import 'package:multi_vendor/shared/data/models/product_model.dart';
import 'package:multi_vendor/shared/data/models/vendor_model.dart';
import 'package:multi_vendor/shared/view/layouts/product_list.dart';
import 'package:multi_vendor/shared/view/widgets/cards/product_card.dart';
import 'package:multi_vendor/shared/view/widgets/circular_box.dart';
import 'package:multi_vendor/shared/view/widgets/verified_chip.dart';

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
    final Color color = vendor.color ?? context.colors.surfaceContainerHighest;
    return Stack(
      children: [
        ColoredBox(
          color: color.veryLight,
          child: Column(
            children: [
              Row(
                spacing: 4.w,
                children: [
                  AppClick(
                    onTap: () =>
                        context.pushNamed(Routes.vendor, arguments: vendor.id),
                    child: _vendorInfo(color, vendor),
                  ),
                  const Spacer(),
                  AppButton.text(
                    onPressed: () => context.pushNamed(
                      Routes.products,
                      arguments: ProductsScreenArgs(
                        initialFilters: ProductsFiltersModel(vendors: [vendor]),
                      ),
                    ),
                    text: AppStrings.viewAll.tr(),
                    color: context.colors.surfaceContainer,
                  ),
                ],
              ).appPaddingAll,
              _productList(products),
            ],
          ).appPaddingVr,
        ),
        _ribbon(AppStrings.advertisement.tr(), context, color: color),
      ],
    );
  }

  Widget _ribbon(String text, BuildContext context, {Color? color}) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.warning,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withAppOpacity(0.2),
              blurRadius: 4.r,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        child: Text(
          text,
          style: TextStyles.bodySmall.copyWith(color: AppColors.white),
        ),
      ),
    );
  }

  Widget _productList(List<ProductModel> products) => SizedBox(
    height: ProductCard.smallSize.height.h,
    child: ProductList(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      clipBehavior: Clip.hardEdge,
      shrinkWrap: false,
      products: products,
    ),
  );

  Widget _vendorInfo(Color color, VendorModel vendor) => Row(
    spacing: 8.w,
    children: [
      CircularBox(
        child: AppCachedNetworkImage(width: 40.w, height: 40.h, vendor.image),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            vendor.name.localized,
            style: TextStyles.labelMedium.copyWith(color: color),
          ),
          if (vendor.isVerified)
            VerifiedChip(title: AppStrings.verifiedVendor.tr()),
        ],
      ),
    ],
  );
}
