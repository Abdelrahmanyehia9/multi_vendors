import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/enum/stock_availability.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/models/variant_model.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/features/shop/product/view/widgets/product_info_section.dart';
import 'package:multi_vendor/features/shop/product/view/widgets/product_variant.dart';
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
import 'add_to_cart_button.dart';

class ProductDetailsBody extends StatefulWidget {
  final ProductDetailsModel model;
  final ValueChanged<Map<String, dynamic>>? onAddCart;

  const ProductDetailsBody({super.key, required this.model, this.onAddCart});

  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> {
  final ValueNotifier<VariantModel?> selectedVariant = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 12.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSlider(
            images: widget.model.sliderImages,
            height: 300,
            placeHolder: widget.model.thumbnail,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.model.rating != null)
                RatingStars(rating: widget.model.rating!, size: 22),
              Text(
                widget.model.category?.name ?? "",
                style: TextStyles.captionMedium,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.h,
            children: [
              ProductNameWithPrice(
                name: widget.model.name ?? "",
                price: widget.model.price,
              ),
              if (FeatureFlags.multiVendor && widget.model.vendor != null)
                AppClick(
                  onTap: () => context.pushNamed(Routes.vendor),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Store"),
                      Gap.small(),
                      CircularBox(
                        child: AppCachedNetworkImage(
                          widget.model.vendor!.image,
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
            body: widget.model.description,
          ),
          if (widget.model.productTags != null)
            ProductInfoSection(
              header: "",
              customBody: Wrap(
                spacing: 4.w,
                runSpacing: 4.h,
                children: widget.model.productTags!
                    .map((e) => AppChip(text: e.toText, selected: true))
                    .toList(),
              ),
            ),
          if (FeatureFlags.enableProductVariants &&
              !widget.model.variants.isNullOrEmpty)
            VariantsSection(
              selectedVariant: selectedVariant,
              showRemaining: true,
              variants: widget.model.variants,
            ),
          ValueListenableBuilder(
            valueListenable: selectedVariant,
            builder: (_, v, __) {
              final inStock = v?.inStock ?? 0;
              return Column(
                spacing: 8.h,
                children: [
                  AddToCartButton(
                      enabled: v != null || widget.model.variants.isNullOrEmpty,
                      onAddToCart: () {}),
                  if (inStock > 0) _stockStatus(inStock),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _stockStatus(int inStock) {
    final stock = StockCountStatus.fromInt(inStock);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: stock.color.veryLight,
        borderRadius: BorderRadius.circular(Decorations.borderRadius8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (stock.icon != null)
            Icon(stock.icon, size: 14.sp, color: stock.color),
          Gap.small(),
          Text(
            stock.message(inStock),
            style: TextStyles.labelSmall.copyWith(color: stock.color),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    selectedVariant.dispose();
    super.dispose();
  }
}
