import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/core/utils/testing.dart';
import 'package:multi_vendor/core/widgets/app_button.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/circular_box.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/widgets/rating_stars.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/core/widgets/app_slider.dart';
import 'package:multi_vendor/features/shop/product/view/widgets/add_to_cart_button.dart';
import 'package:multi_vendor/features/shop/product/view/widgets/product_info_section.dart';
import 'package:multi_vendor/features/shop/product/view/widgets/product_variant.dart';
import '../../../../../core/widgets/cards/product_card.dart';
import '../../../../../core/widgets/scaffold/base_appbar.dart';
import '../../../../core/routes/routes.dart';

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
            _buildMainInfo(),
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

            if(FeatureFlags.enableProductVariants)...[
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
        ),
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
  Widget _buildMainInfo()=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 4.h,
    children: [
      const ProductNameWithPrice(),
      if(FeatureFlags.multiVendor)
      AppClick(
        onTap: ()=>context.pushNamed(Routes.vendor),
        child: const Row(
          spacing: 4,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Store"),
           CircularBox(
                child: AppCachedNetworkImage(Testing.vendor, width: 18,),

            )
          ],
        ),
      ),
    ],
  ) ;

}

