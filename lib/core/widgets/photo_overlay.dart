import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_cached_network_image.dart';

class PhotoOverlay extends StatelessWidget {
  final String? img;
  final Widget? title ;
  final int titlePadding;
  const PhotoOverlay({super.key,this.title, this.titlePadding =16 , this.img});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
         AppCachedNetworkImage(img),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black26, Colors.black54],
              stops: [0.5, 1],
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
