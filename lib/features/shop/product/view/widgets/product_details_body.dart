import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/buttons/add_to_cart_button.dart';
import 'package:multi_vendor/features/shop/product/view/widgets/product_info_section.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';

import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/shared/data/models/product_model.dart';
import 'package:multi_vendor/shared/view/widgets/app_chip.dart';
import 'package:multi_vendor/shared/view/widgets/app_slider.dart';
import 'package:multi_vendor/shared/view/widgets/cards/product_card.dart';
import 'package:multi_vendor/shared/view/widgets/circular_box.dart';
import 'package:multi_vendor/shared/view/widgets/rating_stars.dart';
import 'package:multi_vendor/features/shop/product/data/model/product_details_model.dart';

class ProductDetailsBody extends StatelessWidget {
  final ProductDetailsModel model;
  final ValueChanged<Map<String, dynamic>>? onAddCart;

  const ProductDetailsBody({super.key, required this.model, this.onAddCart});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 18.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSlider(
            images: model.sliderImages,
            thumbnailPosition: ThumbnailPosition.bottom,
            height: 300,
            placeHolder: model.thumbnail,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (model.rating != null)
                AppClick(
                    onTap: () {
                      if(model.id== null) return ;
                      context.pushNamed(Routes.reviewsScreen, arguments: model);
                    },
                    child: RatingStars(rating: model.rating!, size: 22 , spacing: 2,)),
              Text(
                model.category?.name.localized ?? "",
                style: TextStyles.captionMedium,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.h,
            children: [
              ProductNameWithPrice(
                size: 18.sp,
                maxLines: null,
                name: model.name.localized,
                price: model.price,
              ),
              if (FeatureFlags.multiVendor && model.vendor != null)
                AppClick(
                  onTap: () => context.pushNamed(
                    Routes.vendor,
                    arguments: model.vendor?.id,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                       Text(AppStrings.store.tr()),
                      Gap.small(),
                      CircularBox(
                        child: AppCachedNetworkImage(
                          model.vendor!.image,
                          width: 18,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const Divider(height: 0),
          ProductInfoSection(
            header: AppStrings.description.tr(),
            body: model.description?.localized,
          ),
       if (model.productTags != null )
         ProductInfoSection(
           header: AppStrings.productTags.tr(),
           customBody: Wrap(
             spacing: 4.w,
             runSpacing: 4.h,
             children: model.productTags!
                 .map((e) => AppChip(
                 selectedBorderColor: Colors.transparent,
                 textStyle: TextStyles.bodySmall.copyWith(
                   color: context.scaffoldBackground,
                 ),
                 selectedColor: context.colors.surfaceContainerHighest,
                 text: e.toText, selected: true))
                 .toList(),
           ),
         ),

          if (!model.isInStock)
            Center(
              child: Text(
                AppStrings.outOfStock.tr(),
                style: TextStyles.labelMedium.copyWith(color: AppColors.error),
              ),
            )
          else
            AddToCartButton(
              product: ProductModel.fromProductDetails(model),
            ),
        ],
      ),
    );
  }
}
