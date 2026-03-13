import 'package:flutter/material.dart';
import 'package:multi_vendor/core/widgets/cards/product_card.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_section_header.dart';

import '../../../../../core/widgets/gap.dart';

class HomeNewArrival extends StatelessWidget {
  const HomeNewArrival({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeSectionHeader(title: "New arrival", action: "View details",),
        Gap.small(),
        ProductCard.big()
        
      ],
    );
  }
}
