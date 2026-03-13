import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';

import '../theme/decorations.dart';

class AppCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Color? color;
  final double? radius;
  final BlendMode? colorBlendMode;
  final Widget? placeholder;
  final Widget? errorWidget;
  final double? opacity ;
  final Alignment? alignment;

  const AppCachedNetworkImage(
      this.imageUrl, {
        super.key,
        this.width,
        this.height,
        this.fit = BoxFit.cover,
        this.borderRadius,
        this.color,
        this.alignment,
        this.radius,
        this.colorBlendMode,
        this.placeholder,
        this.errorWidget,
        this.opacity
      });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return _buildErrorWidget();
    }

    final image = Opacity(
      opacity: opacity ?? 1,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        color: color,
        alignment: alignment ?? Alignment.center,
        colorBlendMode: colorBlendMode,
        memCacheWidth: 600,
        placeholder: (context, url) =>
            _buildPlaceholder(context),
        errorWidget: (context, url, error) => errorWidget ?? _buildErrorWidget(),
      ),
    );

    if (borderRadius != null || radius != null ) {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(radius!.r),
        child: image,
      );
    }
    return image;
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: context.colors.surfaceContainerLowest,
          borderRadius: borderRadius ?? BorderRadius.circular(radius?.r ?? Decorations.borderRadius8.r)
      ),
      child:  Center(
        child: SizedBox(
          width: 24.w,
          height: 24.h,
          child: placeholder?? const CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: const Icon(Icons.broken_image, color: Colors.grey, size: 32),
    );
  }
}
