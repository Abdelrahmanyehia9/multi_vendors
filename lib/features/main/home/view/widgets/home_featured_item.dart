import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/core/widgets/cards/product_card.dart';
import 'package:multi_vendor/core/widgets/section_header.dart';
import 'package:multi_vendor/features/main/home/logic/home_featured_item_cubit.dart';
import '../../../../../core/models/product_model.dart';
import '../../../../../core/routes/routes.dart';

class HomeFeaturedItem extends StatelessWidget {
  const HomeFeaturedItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<HomeFeaturedItemCubit, ProductModel>(
      successBuilder: (item) => _builder(context, product: item),
      loadingBuilder: () => _builder(context),
    );
  }

  Widget _builder(BuildContext context, {ProductModel? product}) => Column(
    spacing: 8.h,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SectionHeader(
        title: AppConstants.homeFeaturedItem.toText,
        hasAction: true,
        action: "View details",
        onActionTap: () => context.pushNamed(Routes.product),
      ),
      ProductCard.big(
        product: product ?? const ProductModel(name: '', price: null),
      ),
    ],
  );
}
