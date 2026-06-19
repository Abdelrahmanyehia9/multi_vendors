import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/types/type_def.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/intro/view/widgets/onboarding_item.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  static const List<OnBoardingItemData> items = AppConstants.items;
  final PageController _pageController = PageController();
  final _currentIndexNotifier = ValueNotifier(0);

  void _next(isLast) {
    if (isLast) {
      _onFinish();
      return;
    }
    _pageController.animateToPage(
      _currentIndexNotifier.value + 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  void _onFinish() {
    userCubit.finishIntro() ;
    context.pushNamedAndRemoveUntil(Routes.loginScreen, predicate: (_)=>false);
  }
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      paddingHr: 0,
      topSafeArea: true,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: items.length,
              onPageChanged: (i) => _currentIndexNotifier.value = i,
              itemBuilder: (_, i) => OnboardingItem(
                item: items[i],
                currentIndex: i,
                total: items.length,
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: _currentIndexNotifier,
            builder: (context, value, _) {
              final isLast = value == items.length - 1;
              return _action(isLast);
            },
          ),
        ],
      ),
    );
  }

  Widget _action(bool isLast) => Column(
    spacing: 8.h,
    children: [
      AppButton(
        text: isLast ? AppStrings.getStarted.tr() : AppStrings.next.tr(),
        buttonSize: null,
        onPressed: () => _next(isLast),
      ),
      if (!isLast) AppButton.outlined(text: AppStrings.skip.tr(), onPressed: _onFinish),
    ],
  ).appPaddingHr;

  @override
  void dispose() {
    _pageController.dispose();
    _currentIndexNotifier.dispose();
    super.dispose();
  }
}
