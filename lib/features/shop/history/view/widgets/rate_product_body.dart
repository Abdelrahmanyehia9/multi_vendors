import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/widget.dart';

import '../../../../../core/models/rating_model.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/cards/checkout_card.dart';
import '../../../../../core/widgets/rating_stars.dart';

class RateProductBody extends StatelessWidget {
  final bool isLastPage ;
  final GestureTapCallback? onActionPressed ;
  const RateProductBody({super.key,this.onActionPressed ,this.isLastPage = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      children: [
        const CheckoutProductCard(height: 60),
        RatingStars(
          readOnly: false,
          title: "Overall rating",
          rating: RatingModel.fake(),
          onRatingChanged: (rate) {},
          size: 30,
        ),
        const AppTextField(
          headerText: "Product Reviews",
          maxLines: 2,
          maxLength: 150,
          hintText: "Write your review here...",
        ),
        AppButton(
          text: isLastPage ? "Submit your review" : "Next",
          buttonSize: null,
          onPressed: onActionPressed,
        ),
      ],
    ).appPaddingHr;
  }
}
