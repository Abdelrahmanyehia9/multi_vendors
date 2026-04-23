import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import '../../mixin/scroll_visibility.dart';

class StickyBottomLayout extends StatefulWidget {
  final Widget sticky;
  final Widget content;

  const StickyBottomLayout({super.key, required this.content, required this.sticky});

  @override
  State<StickyBottomLayout> createState() => _StickyBottomLayoutState();
}

class _StickyBottomLayoutState extends State<StickyBottomLayout> with ScrollVisibilityMixin {
  static const double _fixedAreaHeight = 60;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: showFixedArea,
      builder: (_, show, __) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          SizedBox.expand(
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: EdgeInsets.only(bottom: show ? _fixedAreaHeight.h : 0),
              child: NotificationListener<ScrollNotification>(
                onNotification: onScrollNotification,
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  child: widget.content.customPadding(
                    top: 16,
                    left: 16,
                    right: 16,
                    bottom: _fixedAreaHeight+16,
                  ),
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: show ? _fixedAreaHeight.h : 0,
            child: widget.sticky.paddingAll(8),
          ),
        ],
      ),
    );
  }
}