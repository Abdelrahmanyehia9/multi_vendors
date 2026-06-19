import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/app_loader_indicator.dart';
import 'package:multi_vendor/shared/view/widgets/app_slider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class AppPhotoView extends StatefulWidget {
  final List<String> images;
  final int? selectedIndex;

  const AppPhotoView._({required this.images, this.selectedIndex});

  @override
  State<AppPhotoView> createState() => _AppPhotoViewState();

  factory AppPhotoView.single({ String? image})=>AppPhotoView._(images: [image ?? ""]);
  factory AppPhotoView.multiple({required List<String?> images, int? index})=>AppPhotoView._(images: images.map((e) => e ?? "").toList(), selectedIndex: index);
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
        loadingBuilder: (_, __) => _buildLoadingState(),
        errorBuilder: (_, __, ___) => _buildErrorState(),
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
          backgroundDecoration: const BoxDecoration(color: Colors.black),
          builder: (_, index) => PhotoViewGalleryPageOptions(
            imageProvider:  CachedNetworkImageProvider(widget.images[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 3,
            errorBuilder: (_, __, ___) =>  _buildErrorState()
          ),
          loadingBuilder: (_, __) => _buildLoadingState(),
          onPageChanged: (index) => setState(() => _currentIndex = index),
        ),
        SliderDots(total: widget.images.length,
            currentIndex: _currentIndex).appPaddingAll
      ],
    );
  }


  Widget _buildErrorState()=>ColoredBox(
    color: Colors.black,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(MvIcons.error,size: 40.sp, color: AppColors.error),
        Text(AppStrings.errorOccurred.tr(), style: TextStyles.labelSmall.copyWith(color: AppColors.error),),
      ],
    ),
  ) ;
  Widget _buildLoadingState()=> const ColoredBox(
    color: Colors.black,
    child:  Center(
        child:  AppLoaderIndicator(
          size: 50,
        )
    ),
  ) ;
}