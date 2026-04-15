import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/di/setup_get_it.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/models/product_model.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/widgets/app_button.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';

import '../../../../../core/models/vendor_model.dart';
import '../../logic/favorite_cubit.dart';

class FavoriteButton extends StatelessWidget {
  final double padding;
  final double size;
  final ProductModel? productModel ;
  final VendorModel? vendorModel;
  final bool isVendor;

  const FavoriteButton._({
    this.size = 18,
    this.padding = 12,
    this.productModel,
    this.vendorModel,
    required this.isVendor,
  });

  factory FavoriteButton.vendor({required VendorModel vendor, double size =18 , double padding = 12}) =>
      FavoriteButton._(isVendor: true, vendorModel: vendor, size: size, padding: padding);
  factory FavoriteButton.product({required ProductModel product, double size =18 , double padding = 12}) =>
      FavoriteButton._(isVendor: false, productModel: product, size: size, padding: padding);

  @override
  Widget build(BuildContext context) {
    int id = productModel?.id ?? vendorModel!.id!;
    return BaseBlocConsumer(
      bloc: favoriteCubit,
      builder:(_) {
        final bool isFavorite = favoriteCubit.isInFavorite(id: id, isProduct: !isVendor) ;
        return AppClick(
          onTap:()=> favoriteCubit.toggleFavorite(isProduct: !isVendor, product: productModel, vendor: vendorModel),
          child: Icon(
          size: size.sp,
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? AppColors.primary : AppColors.grey,
                ).paddingAll(padding),
        );
      },
    );
  }
}
