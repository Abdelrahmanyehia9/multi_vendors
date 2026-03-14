import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/decorations.dart';
import 'app_cached_network_image.dart';

class AppSlider extends StatelessWidget {
  final List<String>images ;
  final double height ;
  const AppSlider({super.key,this.height =250 ,required this.images});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppCachedNetworkImage(
          height: height.h,
          width: double.infinity,
          radius: Decorations.borderRadius16,
          images.first,
        ),
      ],
    );
  }
}
