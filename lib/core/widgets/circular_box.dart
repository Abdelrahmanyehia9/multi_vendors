import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularBox extends StatelessWidget {
  final double radius;
  final Widget? child;
  final Color? backgroundColor;
  final List<BoxShadow >? shadow ;
  final Color? borderColor ;
  final double borderWidth ;
  const CircularBox({super.key,this.child, this.borderColor, this.borderWidth = 2 ,this.shadow ,this.backgroundColor ,this.radius = 16});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius.w,
      height: radius.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: borderColor == null ? null : Border.all(color: borderColor!, width: borderWidth),
        boxShadow: shadow,
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin:  EdgeInsets.all(1.r),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
        ),
        child: child,
      ),
    );
  }
}
