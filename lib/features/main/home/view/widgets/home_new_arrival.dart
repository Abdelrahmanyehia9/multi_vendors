import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/widgets/cards/product_card.dart';
import 'package:multi_vendor/core/widgets/section_header.dart';
import '../../../../../core/routes/routes.dart';

class HomeNewArrival extends StatelessWidget {
  const HomeNewArrival({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: "New arrival",hasAction: true ,action: "View details",onActionTap: ()=>context.pushNamed(Routes.product),),
        ProductCard.big()
      ],
    );
  }
}
