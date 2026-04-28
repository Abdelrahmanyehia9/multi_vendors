import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/shop/history/view/widgets/rate_product_body.dart';
import 'package:multi_vendor/core/widgets/buttons/app_back_button.dart';
import 'package:multi_vendor/core/widgets/buttons/app_forward_button.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';

class RateProductScreen extends StatefulWidget {
  const RateProductScreen({super.key});

  @override
  State<RateProductScreen> createState() => _RateProductScreenState();
}

class _RateProductScreenState extends State<RateProductScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 3;

  void _nextPage() => _pageController.nextPage(
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );
  void _prevPage() => _pageController.previousPage(
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );
  bool get isLastPage => _currentPage == _totalPages - 1;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      paddingHr: 0,
      appBar: BaseAppBar(
        title: "Rate Product ${_currentPage + 1}/$_totalPages",
        leading: _buildLeading(),
        actions: [
          if (!isLastPage)
          AppForwardButton(onTap: _nextPage, backGroundColor: Colors.transparent,),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _totalPages,
        onPageChanged: (i) {
          setState(() => _currentPage = i);
        },
        itemBuilder: (_, i) {
          return RateProductBody(
            isLastPage: isLastPage,
            onActionPressed: isLastPage ? null : _nextPage,
          );
        },
      ),
    );
  }

  Widget _buildLeading() => _currentPage > 0
      ? Padding(
          padding: EdgeInsetsDirectional.only(start: 16.w, top: 16.h),
          child: AppBackButton(
            backgroundColor: Colors.transparent,
            onBack: _prevPage,
          ),
        )
      : const AppBackButton();
}
