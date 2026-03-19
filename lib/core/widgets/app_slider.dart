import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';

import '../theme/decorations.dart';
import 'app_cached_network_image.dart';
import 'gap.dart';

class AppSlider extends StatefulWidget {
  final List<String> images;
  final double height;
  final double viewPort;
  final bool showDots;

  const AppSlider({
    super.key,
    this.height = 250,
    this.viewPort = 1,
    this.showDots = true,
    required this.images,
  });

  @override
  State<AppSlider> createState() => _AppSliderState();
}

class _AppSliderState extends State<AppSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.images.map((i) => _item(i)).toList(),
          options: CarouselOptions(
            height: widget.height.h,
            enlargeCenterPage: true,
            viewportFraction: widget.viewPort,
            onPageChanged: (index, _) {
              if (widget.showDots) {
                setState(() => _currentIndex = index);
              }
            },
          ),
        ),
        if (widget.showDots) ...[
          Gap.medium(),
          SliderDots(
            total: widget.images.length,
            currentIndex: _currentIndex,
          ),
        ],
      ],
    );
  }
  Widget _item(String image) => AppCachedNetworkImage(
    height: widget.height.h,
    width: double.infinity,
    radius: Decorations.borderRadius16,
    image
  );
}


class SliderDots extends StatelessWidget {
  final int total ;
  final int currentIndex;
  const SliderDots({super.key, required this.total, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        total,
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: currentIndex == index ? 30.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Decorations.borderRadius50),
            color: currentIndex == index
                ? AppColors.primary
                : context.colors.surfaceContainerLow,
          ),
        ),
      ),
    );
  }
}
