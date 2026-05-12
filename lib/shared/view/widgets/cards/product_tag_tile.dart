import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/features/main/home/data/models/product_tag_model.dart';
import 'package:multi_vendor/features/shop/product/data/model/products_filters_model.dart';
import 'package:multi_vendor/features/shop/product/view/all_products_screen.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';

class ProductTagTileList extends StatelessWidget {
  final bool shrinkWrap;
  final List<ProductTagModel> tags;
  const ProductTagTileList(

      {
    super.key,
    required this.tags,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tags.length,
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      itemBuilder: (_, i) => ProductTagTile(tag: tags[i]),
    );
  }
}

class ProductTagTile extends StatelessWidget {
  final ProductTagModel tag;
  const ProductTagTile({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    final itemsCount = (tag.count??0) > 999 ? "999+" : tag.count.toString();
    return ListTile(
      onTap: () => context.pushNamed(Routes.products, arguments: ProductsScreenArgs(
        initialFilters: ProductsFiltersModel(tags: [tag])
      ) ),
      contentPadding: EdgeInsets.zero,
      leading: AppCachedNetworkImage(
        width: 70,
        tag.thumbnail,
        radius: Decorations.borderRadius8,
      ),
      title: Text(tag.name, style: TextStyles.bodyMedium,),
      subtitle: Text("$itemsCount ${AppStrings.items.tr()}", style: TextStyles.captionMedium,),
      trailing: const Icon(MvIcons.arrowForward, color: AppColors.primary),
    );
  }
}
