import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/shop/product/view/widgets/review/product_review_distribution_card.dart';
import 'package:multi_vendor/features/shop/product/view/widgets/review/product_review_distribution_tabs.dart';
import 'package:multi_vendor/features/shop/product/view/widgets/review/product_user_review_card.dart';
import 'package:multi_vendor/shared/data/models/rating_model.dart';
import 'package:multi_vendor/shared/view/mixin/scroll_visibility.dart';
import 'package:multi_vendor/shared/view/widgets/section_header.dart';

class ProductReviewsScreen extends StatefulWidget {
  const ProductReviewsScreen({super.key});

  @override
  State<ProductReviewsScreen> createState() => _ProductReviewsScreenState();
}

class _ProductReviewsScreenState extends State<ProductReviewsScreen>
    with ScrollTitleVisibilityMixin {
  final ValueNotifier<int?> selected = ValueNotifier<int?>(null);
  @override
  Widget build(BuildContext context) {
    final rating = const RatingModel(rating: 4.5, count: 100, distribution: RatingDistribution(one: 10, two: 20, three: 30, four: 40, five: 50));
    return BaseScaffold(
      appBar:  BaseAppBar(
        title: "Reviews\nhome shoes",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductReviewDistributionCard(rating: rating),
            Gap.medium(),
            if(rating.distribution != null)
            ProductReviewDistributionTabs(
              distribution: rating.distribution!,
              selected: selected,
            ),
           const SectionHeader(title: "Comments").appPaddingVr,
           ListView.separated(
             padding: EdgeInsets.zero,
             shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(),
               itemBuilder: (_,_)=>const ProductUserReviewCard(),
               separatorBuilder: (_,_)=>Gap.small(),
               itemCount: 13)
          ],
        ),
      ),
    );
  }
}