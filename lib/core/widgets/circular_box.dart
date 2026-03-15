import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularBox extends StatelessWidget {
  final double? radius;
  final Widget? child;
  final Color? backgroundColor;
  final List<BoxShadow >? shadow ;
  final Color? borderColor ;
  final double borderWidth ;
  final  EdgeInsets? padding ;
  final Alignment? alignment;
  const CircularBox({super.key,this.alignment,this.child,this.padding ,this.borderColor, this.borderWidth = 2 ,this.shadow ,this.backgroundColor,this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius?.w,
      height: radius?.h,
      padding: padding,
      alignment: alignment,
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
