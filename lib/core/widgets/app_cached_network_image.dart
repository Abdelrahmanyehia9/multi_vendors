import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/app_logo.dart';
import 'package:multi_vendor/core/widgets/app_photo_view.dart';
import 'package:multi_vendor/core/widgets/overlays/bottom_sheets.dart';

class AppCachedNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Color? color;
  final double? radius;
  final BlendMode? colorBlendMode;
  final Widget? placeholder;
  final Widget? errorWidget;
  final double? opacity;

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
    this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isNullOrEmpty) {
      return _buildPlaceholder(context);
    }
    final image = AppClick(
      enabled: !imageUrl.isNullOrEmpty,
      onDoubleTap: () => BottomSheets.show(
        showCloseButton: true,
        context,
        child: SizedBox(
          height: context.height * 0.9,
          child: AppPhotoView(imgUrl: imageUrl!),
        ),
      ),
      child: Opacity(
        opacity: opacity ?? 1,
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          width: width?.w,
          height: height?.h,
          fit: fit,
          color: color,
          alignment: alignment ?? Alignment.center,
          colorBlendMode: colorBlendMode,
          memCacheWidth: 600,
          placeholder: (context, url) => _buildPlaceholder(context),
          errorWidget: (context, url, error) =>
              errorWidget ?? _buildErrorWidget(),
        ),
      ),
    );
    if (borderRadius != null || radius != null) {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(radius!.r),
        child: image,
      );
    }
    return image;
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      width: width?.w,
      height: height?.h,
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        borderRadius:
            borderRadius ??
            BorderRadius.circular(radius?.r ?? Decorations.borderRadius8.r),
      ),
      child: AppLogo(
        size: 30,
        colorFilter: ColorFilter.mode(
          context.colors.surfaceContainer.withAppOpacity(0.75),
          BlendMode.srcIn,
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      width: width?.w,
      height: height?.h,
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: const Icon(MvIcons.brokenImage, color: Colors.grey, size: 32),
    );
  }
}
