import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/widget.dart';

class WidgetOverlay extends StatelessWidget {
  final bool showOverlay ;
  final Widget child;
  final Color overlayColor ;
  const WidgetOverlay({super.key, required this.showOverlay,required this.child,  this.overlayColor = Colors.black45});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        child.appPaddingHr,
        if (showOverlay)
           AbsorbPointer(
            child: ColoredBox(
              color: overlayColor,
            ),
          )
      ],
    ) ;
  }
}
