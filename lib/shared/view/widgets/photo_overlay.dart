import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';

class PhotoOverlay extends StatelessWidget {
  final String? img;
  final Widget? title ;
  final int titlePadding;
  final double? radius ;
  const PhotoOverlay({super.key, this.radius,this.title, this.titlePadding =16 , this.img});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
         AppCachedNetworkImage(img),
         DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withAppOpacity(0.1), Colors.black.withAppOpacity(0.45), Colors.black.withAppOpacity(0.7)],
              stops: const [0.4,0.8 ,1],
            ),
          ),
        ),
        if(title != null)
        Positioned(
          left: titlePadding.w,
          right: titlePadding.w,
          bottom: titlePadding.h,
          child: title!
        ),
      ],
    );
  }
}
