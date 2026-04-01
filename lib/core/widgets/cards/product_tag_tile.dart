import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/features/main/home/data/models/product_tag_model.dart';

import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/decorations.dart';
import '../app_cached_network_image.dart';

class ProductTagTileList extends StatelessWidget {
  final bool shrinkWrap;

  final List<ProductTagModel> tags;

  const ProductTagTileList({
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
    final itemsCount = tag.count > 999 ? "999+" : tag.count.toString();
    return ListTile(
      onTap: () => context.pushNamed(Routes.products),
      contentPadding: EdgeInsets.zero,
      leading: AppCachedNetworkImage(
        width: 70,
        tag.thumbnail,
        radius: Decorations.borderRadius8,
      ),
      title: Text(tag.name),
      subtitle: Text("$itemsCount items"),
      trailing: const Icon(Icons.arrow_forward, color: AppColors.primary),
    );
  }
}
