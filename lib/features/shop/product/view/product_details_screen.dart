import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/mixin/scroll_visibility.dart';
import 'package:multi_vendor/core/models/rating_model.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/core/utils/testing.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/core/widgets/circular_box.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/widgets/rating_stars.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/core/widgets/app_slider.dart';
import 'package:multi_vendor/features/shop/product/data/model/product_details_model.dart';
import 'package:multi_vendor/features/shop/product/logic/product_details_cubit.dart';
import 'package:multi_vendor/features/shop/product/view/widgets/add_to_cart_button.dart';
import 'package:multi_vendor/features/shop/product/view/widgets/product_info_section.dart';
import '../../../../../core/widgets/scaffold/base_appbar.dart';
import '../../../../core/routes/routes.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> with ScrollTitleVisibilityMixin{
  final ValueNotifier<int> activeSizeIndex = ValueNotifier(0);
  final ValueNotifier<int> activeColorIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(),
      body: BaseBlocConsumer<ProductDetailsCubit, ProductDetailsModel>(
        successBuilder: (p)=>_builder(p),
        loadingBuilder: () {
          final p = ProductDetailsModel.fake();
          return _builder(p);
        },
        failureBuilder: AppStates.error,
      ),
    );
  }

  Widget _builder(ProductDetailsModel model)=>SingleChildScrollView(
    controller: scrollController,
  child: Column(
    spacing: 16.h,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppSlider(images: model.images, placeHolder: model.thumbnail,),
      _buildRating(rating: model.rating, category: model.category?.name),
      _buildMainInfo(context),
      const Divider(height: 0),
      /// product details
      ProductInfoSection(
        header: "Description",
        body: model.description,
      ),
      if(model.productTags != null)
        ProductInfoSection(
          header: "Categories",
          customBody: Wrap(children: model.productTags!.map((e) => Text(e.name)).toList(),),
        ),
      // if(FeatureFlags.enableProductVariants)...[
      //   ProductInfoSection(
      //     header: "Select Color",
      //     customBody: ProductVariant<Color>(
      //       variants: AppColors.mainColors,
      //       activeIndex: activeColorIndex,
      //     ),
      //   ),
      //   ProductInfoSection(
      //     header: "Select Size",
      //     customBody: ProductVariant<String>(
      //       variants: const ["S", "M", "L", "XL"],
      //       activeIndex: activeSizeIndex,
      //     ),
      //   ),
      // ],
      /// product Variants
      const AddToCartButton(),
      Gap.medium()
    ],
  ),
);
  Widget _buildRating({RatingModel? rating , String? category}) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      if(rating != null)
        RatingStars(rating: rating ,  size: 22),
      Text(category ?? "", style: TextStyles.captionMedium),
    ],
  );
  Widget _buildMainInfo(BuildContext context)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 4.h,
    children: [
      // const ProductNameWithPrice(),
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

