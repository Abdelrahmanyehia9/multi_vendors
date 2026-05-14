import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/enum/product_tags.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/features/main/home/data/models/product_tag_model.dart';
import 'package:multi_vendor/features/main/home/logic/home_news_arrivals_cubit.dart';
import 'package:multi_vendor/features/shop/product/data/model/products_filters_model.dart';
import 'package:multi_vendor/features/shop/product/view/all_products_screen.dart';
import 'package:multi_vendor/shared/data/models/product_model.dart';
import 'package:multi_vendor/shared/view/layouts/product_list.dart';
import 'package:multi_vendor/shared/view/widgets/cards/product_card.dart';
import 'package:multi_vendor/shared/view/widgets/section_header.dart';

class HomeNewArrivalsSection extends StatelessWidget {
  const HomeNewArrivalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<HomeNewsArrivalsCubit, List<ProductModel>>(
      successBuilder: (p) => _builder(p, context: context),
      loadingBuilder: () => _builder(
        List.generate(4, (_) => ProductModel.fake()),
        context: context,
      ),
    );
  }

  Widget _builder(
    List<ProductModel> products, {
    required BuildContext context,
  }) => Column(
    children: [
      SectionHeader(
        title: AppStrings.newArrivals.tr(),
        hasAction: true,
        onActionTap: () => context.pushNamed(
          Routes.products,
          arguments: const ProductsScreenArgs(
            initialFilters: ProductsFiltersModel(
              tags: [ProductTagModel(tag: ProductTags.newArrivals)],
            ),
          ),
        ),
      ),
      SizedBox(
        height: ProductCard.smallSize.height.h,
        child: ProductList(shrinkWrap: false, products: products),
      ),
    ],
  );
}
