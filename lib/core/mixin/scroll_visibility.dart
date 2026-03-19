import 'package:flutter/material.dart';

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