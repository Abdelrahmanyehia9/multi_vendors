part of '../home_product_by_vendor.dart';
class _VendorInfo extends StatelessWidget {
  final VendorModel vendor ;
  const _VendorInfo(this.vendor);

  @override
  Widget build(BuildContext context) {
    return AppClick(
      onTap: () =>
          context.pushNamed(Routes.vendor, arguments: vendor.id),
      child:  Row(
        spacing: 8.w,
        children: [
          SizedBox(width: 76.w,),
          Expanded(
            child: Column(
              spacing: 4.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 4.w,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 120.w),
                      child: Text(
                        vendor.name.localized,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.labelSmall.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    if (vendor.isVerified)
                      const VerifiedChip(
                        size: 15,
                      ),
                    ],

                ),
                if(vendor.bio != null)
                  Text(vendor.bio!.localized, maxLines: 3, overflow: TextOverflow.ellipsis , style: TextStyles.captionSmall.copyWith(color: AppColors.white, fontSize: 12.sp)).paddingVr(4),

              ],
            ).paddingVr(4),
          ),
        ],
      ),
    ).paddingVr(8).paddingHr(12);
  }
}
