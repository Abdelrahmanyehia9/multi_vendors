import 'package:flutter/material.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/utils/testing.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_section_header.dart';

class ShopByTags extends StatelessWidget {
  const ShopByTags({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeSectionHeader(title: "You May Like"),
        ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_,i)=>_buildTagTile())

      ],
    );
  }

  Widget _buildTagTile(){
    return const ListTile(
      contentPadding: EdgeInsets.zero,
      leading: AppCachedNetworkImage(
          width: 70,
          Testing.menShirt, radius: Decorations.borderRadius8),
      title: Text("Girl's Fashion"),
      subtitle: Text("999+ items"),
      trailing: Icon(Icons.arrow_forward, color: AppColors.primary,),
      

    );
  }
}
