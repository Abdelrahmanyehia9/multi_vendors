import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/core/utils/testing.dart';
import 'package:multi_vendor/core/widgets/app_button.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/widgets/rating_stars.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/main/shop/product/view/widgets/add_to_cart_button.dart';
import 'package:multi_vendor/features/main/shop/product/view/widgets/product_info_section.dart';
import 'package:multi_vendor/core/widgets/app_slider.dart';
import 'package:multi_vendor/features/main/shop/product/view/widgets/product_variant.dart';
import '../../../../../core/widgets/cards/product_card.dart';
import '../../../../../core/widgets/scaffold/base_appbar.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ValueNotifier<int> activeSizeIndex = ValueNotifier(0);
  final ValueNotifier<int> activeColorIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: "Product details",
        actions: const [
          AppIconButton(icon: Icons.favorite, iconColor: AppColors.primary),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 16.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppSlider(images: [Testing.menShirt],),
            _buildRating(),
            const ProductNameWithPrice(),
             const Divider(height: 0),
            /// product details
            const ProductInfoSection(
              header: "Description",
              body: "The knitwear is made from natural wool, which, by retaining its oils, protects against the cold even in damp conditions. The use of jerseys spread throughout Europe, especially among workers.",
            ),
            const ProductInfoSection(
              header: "Categories",
              body: "Men's Outwear",
            ),

            if(AppConstants.enableProductVariants)...[
              ProductInfoSection(
                header: "Select Color",
                customBody: ProductVariant<Color>(
                  variants: AppColors.mainColors,
                  activeIndex: activeColorIndex,
                ),
              ),
              ProductInfoSection(
                header: "Select Size",
                customBody: ProductVariant<String>(
                  variants: const ["S", "M", "L", "XL"],
                  activeIndex: activeSizeIndex,
                ),
              ),
            ],
            /// product Variants
            const AddToCartButton(),
            Gap.medium()
          ],
        ).appPaddingHr,
      ),
    );
  }

  Widget _buildRating() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const RatingStars(rating: 4.3, count: 23, size: 22),
      Text("Outwear", style: TextStyles.captionMedium),
    ],
  );
}

