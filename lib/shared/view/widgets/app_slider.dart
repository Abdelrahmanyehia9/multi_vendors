import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';

import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/gap.dart';


class AppSlider extends StatefulWidget {
  final List<String>? images;
  final double height;
  final double viewPort;
  final bool showDots;
  final String? placeHolder;
  final List<Widget>? slides ;

  const AppSlider({
    super.key,
    this.height = 250,
    this.viewPort = 1,
    this.showDots = true,
     this.images,
    this.placeHolder,
    this.slides,
  });

  @override
  State<AppSlider> createState() => _AppSliderState();
}

class _AppSliderState extends State<AppSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final int count = widget.images?.length ?? widget.slides?.length ?? 0;
    if(widget.images.isNullOrEmpty && widget.slides.isNullOrEmpty) return AppCachedNetworkImage(widget.placeHolder, height: widget.height, width: double.infinity,radius: Decorations.borderRadius24,) ;
    return Column(
      children: [
        CarouselSlider(
          items:widget.slides ?? widget.images!.map((i) => _item(i)).toList(),
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
            total: count,
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
          duration: const Duration(milliseconds: 400),
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          width: currentIndex == index ? 30.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Decorations.borderRadius24),
            color: currentIndex == index
                ? AppColors.primary
                : context.colors.surfaceContainerLow,
          ),
        ),
      ),
    );
  }
}
