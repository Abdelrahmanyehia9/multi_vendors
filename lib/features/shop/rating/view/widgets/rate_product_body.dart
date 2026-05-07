import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/widgets/app_text_field.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_model.dart';
import 'package:multi_vendor/features/shop/shared/widgets/checkout_list_porducts.dart';
import 'package:multi_vendor/shared/data/models/rating_model.dart';
import 'package:multi_vendor/shared/view/widgets/rating_stars.dart';

class RateProductBody extends StatefulWidget {
  final ValueChanged<double>ratingChanged ;
  final ValueChanged<String?>commentChanged ;
  final CartModel item;
  const RateProductBody({super.key,
    required this.ratingChanged,
    required this.item,
    required this.commentChanged,
  });

  @override
  State<RateProductBody> createState() => _RateProductBodyState();
}



class _RateProductBodyState extends State<RateProductBody> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      spacing: 12.h,
      children: [
        CheckoutProductCard(
            onTap: (){},
            item: widget.item),
          RatingStars(
          readOnly: false,
          showCount: false,
          title: "Overall rating",
          rating: const RatingModel(
            rating: 0,
            count: 0,
          ),
          onRatingChanged: widget.ratingChanged,
          size: 24,
        ),
          AppTextField(
          headerText: "Product Reviews",
          maxLines: 2,
          maxLength: 150,
          hintText: "Write your review here...",
          onChange: widget.commentChanged,
        ),

      ],
    );
  }

  @override
  bool get wantKeepAlive =>true;
}
