import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/features/shop/history/data/model/review_request_model.dart';
import 'package:multi_vendor/features/shop/history/logic/order_submit_review_cubit.dart';
import 'package:multi_vendor/features/shop/history/view/rate_product_screen.dart';
import 'package:flutter/material.dart';


mixin RateProductScreenMixin on State<RateProductScreen> {
  late final PageController pageController;
  late final ValueNotifier<int> currentPage;
  late final int totalPages;
  late final List<ReviewRequestModel> reviews;
  OrderSubmitReviewCubit get cubit => context.read<OrderSubmitReviewCubit>();

  @override
  void initState() {
    super.initState();
    currentPage = ValueNotifier<int>(widget.args.initialItem);
    totalPages = widget.args.items.length;
    pageController = PageController(initialPage: currentPage.value,);
    reviews = List.generate(totalPages, (i) =>
        ReviewRequestModel(
          itemId: widget.args.items[i].orderItemId!,
          productId: widget.args.items[i].product.id,
        ));
  }

  void nextPage() {
    if (!isLastPage) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  void submitReviews() {
  cubit.submitReviews(reviews);
  }

  void prevPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void onPageChanged(int page) {
    currentPage.value = page;
  }

  bool get isLastPage => currentPage.value == totalPages - 1;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}