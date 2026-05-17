import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/shop/product/data/model/product_details_model.dart';
import 'package:multi_vendor/features/shop/rating/data/models/user_review_model.dart';
import 'package:multi_vendor/features/shop/rating/logic/user_reviews_cubit.dart';
import 'package:multi_vendor/features/shop/rating/view/mixin/reviews_screen_mixin.dart';
import 'package:multi_vendor/features/shop/rating/view/widgets/product_review_distribution_card.dart';
import 'package:multi_vendor/features/shop/rating/view/widgets/product_review_distribution_tabs.dart';
import 'package:multi_vendor/features/shop/rating/view/widgets/product_user_review_card.dart';
import 'package:multi_vendor/shared/view/widgets/section_header.dart';




class ReviewsScreen extends StatefulWidget {
  final ProductDetailsModel model ;
  const ReviewsScreen({super.key, required this.model});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen>
    with  ReviewScreenMixin {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar:  BaseAppBar(
        title: "${AppStrings.reviews.tr()}\n${widget.model.name.localized}",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductReviewDistributionCard(rating: rating),
            Gap.large(),
            ProductReviewDistributionTabs(
              distribution: (rating?.distributionList ?? []),
              selected: selected,
            ),
            BaseBlocConsumer<UserReviewsCubit, List<UserReviewModel>>(
              successBuilder: (reviews)=>_builder(reviews),
              loadingBuilder: ()=>_builder(List.generate(10, (_) => UserReviewModel.fake())),
              failureBuilder: AppStates.error,
              emptyBuilder: AppStates.empty,
            )
          ],
        ),
      ),
    );
  }

  Widget _builder(List<UserReviewModel> reviews)=>Column(
    children: [
       SectionHeader(title: AppStrings.comments.tr()).appPaddingVr,
      ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_,i)=> ProductUserReviewCard(model: reviews[i],),
          separatorBuilder: (_,_)=>Gap.small(),
          itemCount: reviews.length
      )
    ],
  ) ;
}