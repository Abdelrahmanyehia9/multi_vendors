import 'package:flutter/material.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';

import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/gap.dart';

class ProductFiltersAction extends StatelessWidget {
  final double gap ;
  const ProductFiltersAction({super.key, this.gap =4});

  @override
  Widget build(BuildContext context) {
    if(FeatureFlags.enableProductFilters){
      return Row(
        children: [
          const AppIconButton(icon: Icons.filter_alt),
          Gap(gap),
          const AppIconButton(icon: Icons.sort),
        ],
      );
    }else{
      return const SizedBox.shrink();
    }

  }
}
