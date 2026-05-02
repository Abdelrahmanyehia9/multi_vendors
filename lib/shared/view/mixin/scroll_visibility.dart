import 'package:flutter/material.dart';

import 'package:multi_vendor/core/theme/text_styles.dart';

mixin ScrollVisibilityMixin<T extends StatefulWidget> on State<T> {
  final ScrollController scrollController = ScrollController();
  final ValueNotifier<bool> showFixedArea = ValueNotifier(true);

  bool onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      final delta = notification.scrollDelta ?? 0;
      final pixels = notification.metrics.pixels;
      if (delta > 2 && pixels > 0) showFixedArea.value = false;
    }
    if (notification is ScrollEndNotification) showFixedArea.value = true;
    return false;
  }
  @override
  void dispose() {
    scrollController.dispose();
    showFixedArea.dispose();
    super.dispose();
  }
}

mixin ScrollTitleVisibilityMixin<T extends StatefulWidget> on State<T> {
  final ScrollController scrollController = ScrollController();
  final ValueNotifier<bool> showTitle = ValueNotifier(false);

  double get titleThreshold => 210.0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }
  void _onScroll() {
    final shouldShow = scrollController.offset  > titleThreshold ;
    if (shouldShow != showTitle.value) {
      showTitle.value = shouldShow;
    }
  }
  Widget title(String? title){
    return ValueListenableBuilder(
      valueListenable: showTitle,
      builder: (_, value, _) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.3),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
        child: value
            ? Text(
          title ?? "",
          key: const ValueKey('title'),
          style: TextStyles.bodyMedium,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        )
            : const SizedBox.shrink(),
      ),
    ) ;
  }
  @override
  void dispose() {
    scrollController.dispose();
    showTitle.dispose();
    super.dispose();
  }
}