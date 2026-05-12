import 'package:flutter/material.dart';
import 'package:multi_vendor/features/main/home/data/models/product_tag_model.dart';
import 'package:multi_vendor/shared/view/widgets/cards/product_tag_tile.dart';

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
