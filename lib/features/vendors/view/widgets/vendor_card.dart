import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/utils/app_configs.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/features/main/favorite/view/widgets/app_favorite_button.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/shared/data/models/rating_model.dart';
import 'package:multi_vendor/shared/data/models/vendor_model.dart';
import 'package:multi_vendor/shared/view/widgets/photo_overlay.dart';
import 'package:multi_vendor/shared/view/widgets/rating_stars.dart';

class VendorsCardList extends StatelessWidget {
  final bool shrinkWrap;
  final List<VendorModel> vendors ;
  const VendorsCardList({super.key,required this.vendors ,this.shrinkWrap = false});

  @override
  Widget build(BuildContext context) => ListView.separated(
    itemCount: vendors.length,
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
        onTap: () => context.pushNamed(Routes.vendor, arguments: vendor.id),
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
                    Text(vendor.name.localized, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyles.bodyMedium),
                    RatingStars(rating: RatingModel.fake(),),
                    Row(
                      spacing: 8.w,
                      children: [
                        _iconText(MvIcons.delivery, "40 ${AppConfigs.currency.name}"),
                        _iconText(MvIcons.timelapse, "20-50 ${AppStrings.minutePlural.tr()}"),
                      ],
                    ),
                    if (FeatureFlags.enableMultiShipping) ...[
                      Gap.tiny(),
                      Row(
                        spacing: 4.w,
                        children: [
                          Text(AppStrings.deliverBy.tr(), style: TextStyles.bodySmall.copyWith(color: AppColors.primary)),
                          Text("( ${AppStrings.store.tr()} )", style: TextStyles.bodySmall),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(MvIcons.arrowForward),
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
          title: Text(vendor.name.localized, style: TextStyles.bodySmall.copyWith(color: AppColors.white)),
        ),
      ),
      AppFavoriteButton(item: vendor),
    ],
  );

}
