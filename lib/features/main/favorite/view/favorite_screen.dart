import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/widgets/cards/product_card.dart';
import '../../../../core/widgets/scaffold/base_appbar.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 90.h,
          child: BaseAppBar(
            title: "Favorite",
          ),
        ),
         Expanded(
          child: const ProductGrid(
            shrinkWrap: true,
          ).appPaddingHr,
        ),
      ],
    ) ;
  }
}
