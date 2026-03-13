import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';

class AddToFavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final double padding ;
  final double size ;
  const AddToFavoriteButton({super.key,this.size =18,this.padding =4 ,this.isFavorite = false});

  @override
  Widget build(BuildContext context) {
    return Icon(
      size: size.sp,
      isFavorite ? Icons.favorite : Icons.favorite_border,
      color: isFavorite ? AppColors.primary : AppColors.grey,
    ).paddingAll(padding);
  }
}
