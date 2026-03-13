import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Gap extends StatelessWidget {
  final double size;
  const Gap(this.size, {super.key});



  factory Gap.medium()=>const Gap(16) ;
  factory Gap.small()=>const Gap(8) ;
  factory Gap.extraSmall()=>const Gap(4) ;
  factory  Gap.large()=>const Gap(24) ;
  factory Gap.extraLarge()=>const Gap(32) ;
  factory Gap.huge()=>const Gap(40) ;
  factory Gap.tiny()=>const Gap(2) ;

  @override
  Widget build(BuildContext context) {
    Axis? axis;
    context.visitAncestorElements((element) {
      final widget = element.widget;
      if (widget is Flex) {
        axis = widget.direction;
        return false;
      }
      return true;
    });

    if (axis == Axis.horizontal) {
      return SizedBox(width: size.w);
    } else {
      return SizedBox(height: size.h);
    }
  }
}
