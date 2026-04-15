import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/models/vendor_model.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/photo_overlay.dart';
import 'package:multi_vendor/features/main/favorite/view/widgets/add_to_favorite_button.dart';
import '../../../../core/models/rating_model.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/decorations.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/feature_flags.dart';
import '../../../../core/widgets/app_cached_network_image.dart';
import '../../../../core/widgets/gap.dart';
import '../../../../core/widgets/rating_stars.dart';

class VendorsCardList extends StatelessWidget {
  final bool shrinkWrap;
  final List<VendorModel> vendors ;
  const VendorsCardList({super.key,required this.vendors ,this.shrinkWrap = false});

  @override
  Widget build(BuildContext context) => ListView.separated(
    itemCount: 5,
    shrinkWrap: shrinkWrap,
    physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
    separatorBuilder: (_, __) => Divider(height: 24.h),
    itemBuilder: (_, i) =>  VendorCard(vendor: vendors[i],),
  );


}
class VendorCard extends StatelessWidget {
  final VendorModel vendor ;
  const VendorCard({super.key,required this.vendor });
  static const Size cardSize = Size(double.infinity, 100);

  @override
  Widget build(BuildContext context) {

    return AppClick(
        onTap: () => context.pushNamed(Routes.vendor,),
        child: SizedBox(
          height: cardSize.height.h,
          child: Row(
            children: [
              AppCachedNetworkImage(
                vendor.image,
                width: 120,
                height: cardSize.height.h,
                radius: Decorations.borderRadius16,
              ),
              Gap.small(),
              Expanded(
                child: Column(
                  spacing: 4.h,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(vendor.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyles.bodyMedium),
                    RatingStars(rating: RatingModel.fake(),),
                    Row(
                      spacing: 8.w,
                      children: [
                        _iconText(Icons.delivery_dining, "40 EGP"),
                        _iconText(Icons.timelapse, "20-50 min"),
                      ],
                    ),
                    if (FeatureFlags.enableMultiShipping) ...[
                      Gap.tiny(),
                      Row(
                        spacing: 4.w,
                        children: [
                          Text("Deliver by", style: TextStyles.bodySmall.copyWith(color: AppColors.primary)),
                          Text("( Store )", style: TextStyles.bodySmall),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward),
            ],
          ),
        ));
  }

  Widget _iconText(IconData icon, String text) => Row(
    children: [
      Icon(icon, size: 16.sp),
      Gap.tiny(),
      Text(text, style: TextStyles.captionSmall),
    ],
  );
}
class VendorCardGrid extends StatelessWidget {
  final bool shrinkWrap;
  final List<VendorModel> vendors ;
  const VendorCardGrid({super.key,required this.vendors ,this.shrinkWrap = false});

  @override
  Widget build(BuildContext context) => GridView.builder(
    itemCount: vendors.length,
    shrinkWrap: shrinkWrap,
    physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 4.w,
      crossAxisSpacing: 4.h,
    ),
    itemBuilder: (_, i) =>  AppClick(
        onTap: ()=>context.pushNamed(Routes.vendor, arguments: vendors[i].id),
        child: _item(vendor: vendors[i])),
  );

  Widget _item({required VendorModel vendor})=>Stack(
    alignment: AlignmentDirectional.topEnd,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(Decorations.borderRadius8.r),
        child: PhotoOverlay(
          img: vendor.image,
          titlePadding: 8,
          title: Text(vendor.name, style: TextStyles.bodySmall.copyWith(color: AppColors.white)),
        ),
      ),
      FavoriteButton.vendor(vendor: vendor)
    ],
  );

}
