import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/utils/app_configs.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/features/main/home/logic/home_featured_item_cubit.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/shared/data/models/product_model.dart';
import 'package:multi_vendor/shared/view/widgets/cards/product_card.dart';
import 'package:multi_vendor/shared/view/widgets/section_header.dart';

class HomeFeaturedItem extends StatelessWidget {
  const HomeFeaturedItem({super.key});

  @override
  Widget build(BuildContext context) {
    if (AppConfigs.homeFeaturedItem == null) return const SizedBox.shrink();
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
        title: AppConfigs.homeFeaturedItem!.toText,
        hasAction: true,
        action: AppStrings.viewDetails.tr(),
        onActionTap: () => context.pushNamed(Routes.product, arguments: product!.id),
      ),
      ProductCard.big(
        product: product ?? const ProductModel(name: {}, price: null),
      ),
    ],
  );
}
