import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/app_photo_view.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/widgets/overlays/bottom_sheets.dart';

enum ThumbnailPosition { bottom, side, dots }

class AppSlider extends StatefulWidget {
  final List<String>? images;
  final double? height;
  final double viewPort;
  final ThumbnailPosition thumbnailPosition;
  final String? placeHolder;
  final List<Widget>? slides;
  final bool showThumbnail;

  const AppSlider({
    super.key,
    this.height ,
    this.viewPort = 1,
    this.thumbnailPosition = ThumbnailPosition.dots,
    this.images,
    this.placeHolder,
    this.slides,
    this.showThumbnail = true,
  });

  @override
  State<AppSlider> createState() => _AppSliderState();
}

class _AppSliderState extends State<AppSlider> {
  int _currentIndex = 0;
  late final CarouselSliderController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CarouselSliderController();
  }

  void _onThumbnailTap(int index) {
    _controller.animateToPage(index);
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.images;
    final slides = widget.slides;

    if (images.isNullOrEmpty && slides.isNullOrEmpty) {
      return AppCachedNetworkImage(
        widget.placeHolder,
        height: widget.height,
        width: double.infinity,
        enableViewer: true,
        radius: Decorations.borderRadius24,
      );
    }

    final carousel = CarouselSlider(
      carouselController: _controller,
      items: slides ?? images!.map((i) => _item(i)).toList(),
      options: CarouselOptions(
        height: widget.height?.h,
        enlargeCenterPage: true,
        viewportFraction: widget.viewPort,
        onPageChanged: (index, _) => setState(() => _currentIndex = index),
      ),
    );

    if (widget.thumbnailPosition == ThumbnailPosition.dots || images == null) {
      return Column(
        children: [
          carousel,
          if ((widget.slides?.length ?? images?.length ?? 0) > 1) ...[
            Gap.small(),
            if(widget.showThumbnail)
            SliderDots(total: images?.length ?? widget.slides!.length, currentIndex: _currentIndex),
          ],
        ],
      );
    }

    if (widget.thumbnailPosition == ThumbnailPosition.side) {
      return Stack(
        children: [
          Expanded(child: carousel),
          if(widget.showThumbnail)
          _VerticalThumbnails(
            images: images,
            currentIndex: _currentIndex,
            height: widget.height??250,
            onTap: _onThumbnailTap,
          ).paddingAll(8),
        ],
      );
    }

    // bottom
    return Column(
      children: [
        carousel,
        Gap.small(),
        if(widget.showThumbnail)
        _HorizontalThumbnails(
          images: images,
          currentIndex: _currentIndex,
          onTap: _onThumbnailTap,
        ),
      ],
    );
  }

  Widget _item(String image) => AppClick(
    onTap: () {
      BottomSheets.show(
      showCloseButton: true,
      context,
      child: SizedBox(
        height: context.height * 0.9,
        child: AppPhotoView(images: widget.images!, selectedIndex: _currentIndex),
      ),
    );
    },
    child: AppCachedNetworkImage(
      image,
      height: widget.height?.h,
      width: double.infinity,
      radius: Decorations.borderRadius16,
    ),
  );
}

// ─── Horizontal Thumbnails ───────────────────────────────────────────────────

class _HorizontalThumbnails extends StatelessWidget {
  final List<String> images;
  final int currentIndex;
  final void Function(int) onTap;

  const _HorizontalThumbnails({
    required this.images,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (_, index) => _Thumbnail(
          image: images[index],
          isSelected: currentIndex == index,
          onTap: () => onTap(index),
        ),
      ),
    );
  }
}

// ─── Vertical Thumbnails ─────────────────────────────────────────────────────

class _VerticalThumbnails extends StatelessWidget {
  final List<String> images;
  final int currentIndex;
  final double height;
  final void Function(int) onTap;

  const _VerticalThumbnails({
    required this.images,
    required this.currentIndex,
    required this.height,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.w,
      height: height.h,
      child: ListView.separated(
        itemCount: images.length,
        separatorBuilder: (_, __) => Gap.small(),
        itemBuilder: (_, index) => _Thumbnail(
          image: images[index],
          isSelected: currentIndex == index,
          onTap: () => onTap(index),
        ),
      ),
    );
  }
}

// ─── Single Thumbnail ─────────────────────────────────────────────────────────

class _Thumbnail extends StatelessWidget {
  final String image;
  final bool isSelected;
  final VoidCallback onTap;

  const _Thumbnail({
    required this.image,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppClick(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Decorations.borderRadius12.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2.2.sp,
          ),
        ),
        child: AppCachedNetworkImage(
          image,
          radius: Decorations.borderRadius8,
          height: 40.h,
          width: 50.w,
        ),
      ),
    );
  }
}

// ─── Dots ─────────────────────────────────────────────────────────────────────

class SliderDots extends StatelessWidget {
  final int total;
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