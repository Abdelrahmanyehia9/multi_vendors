import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';

import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/decorations.dart';
import '../../utils/testing.dart';
import '../app_cached_network_image.dart';

class ProductTagTileList extends StatelessWidget {
  final bool shrinkWrap ;
  const ProductTagTileList({super.key, this.shrinkWrap = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        shrinkWrap: shrinkWrap,
        physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
        itemBuilder: (_,__)=>const ProductTagTile());
  }
}





class ProductTagTile extends StatelessWidget {
  const ProductTagTile({super.key});
  @override
  Widget build(BuildContext context) {
    return  ListTile(
      onTap: ()=>context.pushNamed(Routes.products),
      contentPadding: EdgeInsets.zero,
      leading: const AppCachedNetworkImage(
          width: 70,
          Testing.menShirt, radius: Decorations.borderRadius8),
      title: const Text("Girl's Fashion"),
      subtitle: const Text("999+ items"),
      trailing: const Icon(Icons.arrow_forward, color: AppColors.primary,),


    );
  }
}
