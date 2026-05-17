import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/app_loader_indicator.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class AppPhotoView extends StatefulWidget {
  final List<String> images;
  final int? selectedIndex;

  const AppPhotoView({super.key, required this.images, this.selectedIndex});

  @override
  State<AppPhotoView> createState() => _AppPhotoViewState();
}

class _AppPhotoViewState extends State<AppPhotoView> {
  late int _currentIndex;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.selectedIndex ?? 0;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.length == 1) {
      return PhotoView(
        imageProvider: CachedNetworkImageProvider(widget.images.first),
        loadingBuilder: (_, __) => const Center(child: AppLoaderIndicator()),
        errorBuilder: (_, __, ___) => const Icon(MvIcons.error, color: AppColors.error),
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        strictScale: true,
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 3,
      );
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PhotoViewGallery.builder(
          pageController: _pageController,
          itemCount: widget.images.length,
          builder: (_, index) => PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(widget.images[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 3,
            errorBuilder: (_, __, ___) => const Icon(MvIcons.error, color: AppColors.error),
          ),
          loadingBuilder: (_, __) => const Center(child: SizedBox(
              width: 100,
              height: 100,
              child: AppLoaderIndicator())),
          backgroundDecoration: const BoxDecoration(color: Colors.black),
          onPageChanged: (index) => setState(() => _currentIndex = index),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.images.length,
                  (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentIndex == index ? 16 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentIndex == index ? Colors.white : Colors.white38,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}