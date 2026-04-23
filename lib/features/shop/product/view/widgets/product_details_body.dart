import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/widgets/buttons/add_to_cart_button.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_model.dart';
import 'package:multi_vendor/features/shop/product/view/widgets/product_info_section.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/utils/feature_flags.dart';
import '../../../../../core/widgets/app_cached_network_image.dart';
import '../../../../../core/widgets/app_chip.dart';
import '../../../../../core/widgets/app_click.dart';
import '../../../../../core/widgets/app_slider.dart';
import '../../../../../core/widgets/cards/product_card.dart';
import '../../../../../core/widgets/circular_box.dart';
import '../../../../../core/widgets/gap.dart';
import '../../../../../core/widgets/rating_stars.dart';
import '../../data/model/product_details_model.dart';

class ProductDetailsBody extends StatelessWidget {
  final ProductDetailsModel model;
  final ValueChanged<Map<String, dynamic>>? onAddCart;

  const ProductDetailsBody({super.key, required this.model, this.onAddCart});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 12.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSlider(
            images: model.sliderImages,
            height: 300,
            placeHolder: model.thumbnail,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (model.rating != null)
                RatingStars(rating: model.rating!, size: 22),
              Text(
                model.category?.name ?? "",
                style: TextStyles.captionMedium,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.h,
            children: [
              ProductNameWithPrice(
                name: model.name ?? "",
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
                      const Text("Store"),
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
            header: "Description",
            body: model.description,
          ),
          if (model.productTags != null)
            ProductInfoSection(
              header: "Product Tags",
              customBody: Wrap(
                spacing: 4.w,
                runSpacing: 4.h,
                children: model.productTags!
                    .map((e) => AppChip(text: e.toText, selected: true))
                    .toList(),
              ),
            ),

          if (!model.isInStock)
            Center(
              child: Text(
                "Out of Stock",
                style: TextStyles.labelMedium.copyWith(color: AppColors.error),
              ),
            )
          else
            AddToCartButton(
              product: CartProductModel.fromProductModel(model),
            ),
        ],
      ),
    );
  }
}
