import 'dart:math' as math;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/buttons/app_icon_button.dart';
import 'package:multi_vendor/features/main/favorite/data/model/favorite_item.dart';
import 'package:multi_vendor/features/main/favorite/view/mixin/favorite_animation_mixin.dart';

class AppFavoriteButton extends StatefulWidget {
  final FavoriteItem item;
  final double padding;
  final double size;
  final double radius ;

  const AppFavoriteButton({
    this.size = 18,
    this.padding = 12,
    super.key,
    this.radius = 12,
    required this.item,
  });

  @override
  State<AppFavoriteButton> createState() => _AppFavoriteButtonState();
}


class _AppFavoriteButtonState extends State<AppFavoriteButton>
    with SingleTickerProviderStateMixin, FavoriteAnimationMixin {

  @override
  Widget build(BuildContext context) {
    if (!FeatureFlags.enableFavorite) return const SizedBox.shrink();
    return Tooltip(
      message: AppStrings.favorite.tr(),
      child: BaseBlocConsumer(
        bloc: favoriteCubit,
        builder: (_) {
          final bool isFavorite = favoriteCubit.isInFavorite(widget.item);
          return AppClick(
            onTap: () => _handleTap(),
            child: AnimatedBuilder(
              animation: favoriteAnimController,
              builder: (context, _) => SizedBox(
                width: widget.size.sp + widget.padding * 2,
                height: widget.size.sp + widget.padding * 2,
                child: Stack(
                  alignment: AlignmentGeometry.center,
                  clipBehavior: Clip.none,
                  children: [
                    Transform.scale(
                      scale: favoriteScaleAnim.value,
                      child: AppIconButton(
                        size: widget.size.sp,
                        radius: widget.radius,
                        icon :isFavorite ? MvIcons.favorite : MvIcons.favoriteOutlined,
                        iconColor: isFavorite ? AppColors.error : context.colors.surfaceContainerHigh,
                      ),
                    ),
                    if (favoriteAnimController.isAnimating && isFavorite)
                      ..._buildParticles(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildParticles() {
    return List.generate(6, (i) {
      final angle = (i / 8) * 2 * math.pi;
      final distance = favoriteParticleAnim.value * widget.size.sp * 1.3;
      final opacity = (1 - favoriteParticleAnim.value).clamp(0.0, 1.0);
      return Positioned(
        left: widget.padding +
            widget.size.sp / 2 +
            math.cos(angle) * distance -
            3,
        top: widget.padding +
            widget.size.sp / 2 +
            math.sin(angle) * distance -
            3,
        child: Opacity(
          opacity: opacity,
          child: Icon(
            MvIcons.fire,
            size: 8.sp,
            color: AppColors.mainColors[
            i % AppColors.mainColors.length],
          ),
        ),
      );
    });

  }
  void _handleTap()  {
    playFavoriteAnimation();
     favoriteCubit.toggleFavorite(widget.item);
  }
}