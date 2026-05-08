import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_model.dart';
import 'package:multi_vendor/features/shop/history/logic/helper/order_history_helper.dart';
import 'package:multi_vendor/features/shop/rating/view/mixin/rate_product_screen_mixin.dart';
import 'package:multi_vendor/features/shop/rating/view/widgets/rate_product_body.dart';
import 'package:multi_vendor/core/widgets/buttons/app_back_button.dart';
import 'package:multi_vendor/core/widgets/buttons/app_forward_button.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';

final class RateProductScreensArgs {
  final List<CartModel> items;
  final int initialItem;
  const RateProductScreensArgs({required this.items,  this.initialItem =0 });
}

class RateProductScreen extends StatefulWidget {
 final RateProductScreensArgs args ;
  const RateProductScreen({
    super.key,
    required this.args
  });

  @override
  State<RateProductScreen> createState() => _RateProductScreenState();
}

class _RateProductScreenState extends State<RateProductScreen> with RateProductScreenMixin{

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentPage,
      builder: (context, value, child) {
        return BaseScaffold(
          paddingHr: 0,
          appBar: BaseAppBar(
            title: "${AppStrings.rateProduct.tr()} ${value + 1}/$totalPages",
            leading: _buildLeading(),
            actions: [
              if (!isLastPage)
                AppForwardButton(
                  onTap: nextPage,
                  backGroundColor: Colors.transparent,
                ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: totalPages,
                  onPageChanged: onPageChanged,
                  itemBuilder: (_, i) {
                    return RateProductBody(
                      item: widget.args.items[i],
                      ratingChanged: (rate)=>reviews[i] = reviews[i].copyWith(rate: rate.floor()),
                      commentChanged: (comment)=>reviews[i] = reviews[i].copyWith(comment: comment),
                    ).appPaddingHr;
                  },
                ),
              ),
              BaseBlocConsumer(
                bloc: cubit,
                onFailure: (e)=>context.errorBar(message: e.message),
                onSuccess: (_)=>OrderHistoryHelper.onRatingSuccess(context),
                builder:(s)=> AppButton(
                  isLoading: s.isLoading,
                  text: isLastPage ? AppStrings.submitYourReview.tr() : AppStrings.next.tr(),
                  buttonSize: null,
                  onPressed: isLastPage ? submitReviews : nextPage,
                ).appPaddingHr,
              ),
            ],
          ),
        );
      }
    );
  }

  Widget _buildLeading() => currentPage.value > 0
      ? AppBackButton(backgroundColor: Colors.transparent, onBack: prevPage)
      : const AppBackButton();
}
