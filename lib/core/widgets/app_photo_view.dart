import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/app_loader_indicator.dart';
import 'package:photo_view/photo_view.dart';

class AppPhotoView extends StatelessWidget {
  final  String imgUrl ;
  const AppPhotoView({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: PhotoView(
        wantKeepAlive: true,
        enablePanAlways: true,
        imageProvider: CachedNetworkImageProvider(imgUrl),
        loadingBuilder:
            (context, event) => const Center(
          child: AppLoaderIndicator()
        ),
        strictScale: true,
        errorBuilder:
            (context, error, stackTrace) =>
        const Icon(MvIcons.error, color: AppColors.error),
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 3,
      ),
    );
  }
}
