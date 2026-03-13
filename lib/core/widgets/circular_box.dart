import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularBox extends StatelessWidget {
  final double radius;
  final Widget? child;
  final Color? backgroundColor;
  const CircularBox({super.key,this.child , this.backgroundColor ,this.radius = 16});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: radius.w,
      height: radius.w,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor
      ),
      child: child,
    );
  }
}
