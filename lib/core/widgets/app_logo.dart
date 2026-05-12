import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/utils/app_assets.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final ColorFilter? colorFilter ;
  const AppLogo({super.key, this.size = 50, this.colorFilter});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        colorFilter: colorFilter,
        context.isDark ? AppAssets.appLogoDark : AppAssets.appLogo,
        width: size.w,
        height: size.h,
      ),
    );
  }
}
