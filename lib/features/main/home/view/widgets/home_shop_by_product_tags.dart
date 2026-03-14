import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/widgets/section_header.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/widgets/cards/product_tag_tile.dart';

class ShopByProductTags extends StatelessWidget {
  const ShopByProductTags({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         SectionHeader(title: "Filter by ${AppConstants.tagsString}", onActionTap: ()=>context.pushNamed(Routes.productTags),),
        const ProductTagTileList(shrinkWrap: true,)

      ],
    );
  }
}


