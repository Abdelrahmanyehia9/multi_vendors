import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/di/setup_get_it.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/features/main/favorite/data/model/favorite_item.dart';


class AppFavoriteButton extends StatelessWidget {
  final FavoriteItem item ;
  final double padding;
  final double size;
  const AppFavoriteButton({
    this.size = 18,
    this.padding = 12,
    super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    if(!FeatureFlags.enableFavorite)return const SizedBox.shrink() ;
    return BaseBlocConsumer(
      bloc: favoriteCubit,
      builder:(_) {
        final bool isFavorite = favoriteCubit.isInFavorite(item) ;
        return AppClick(
          onTap:()=>_toggleFavorite(isFavorite: isFavorite , context: context),
          child: Icon(
            size: size.sp,
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? AppColors.primary : AppColors.grey,
          ).paddingAll(padding),
        );
      },
    );


  }
  void _toggleFavorite({required bool isFavorite ,required BuildContext context})async{
    final message = "${item.displayName} ${isFavorite?"removed" : "added"} Successfully ${isFavorite?"From" : "To"} Favorite" ;
    context.loaderOverlay.show() ;
    await favoriteCubit.toggleFavorite(item);
    if(context.mounted) {
      context.loaderOverlay.hide() ;
      context.successBar(message: message);
    }
  }

}


