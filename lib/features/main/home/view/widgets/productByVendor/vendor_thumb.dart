part of '../home_product_by_vendor.dart';
class _VendorThumb extends StatelessWidget {
  final VendorModel vendor;
  const _VendorThumb(this.vendor);

  @override
  Widget build(BuildContext context) {
    return AppClick(
      onTap: ()=>context.pushNamed(Routes.vendor, arguments: vendor.id),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Decorations.borderRadius8.r),
            border: Border.all(color: AppColors.white , )),
        child: AppCachedNetworkImage(width: 70.w, height: 66.h, vendor.image , radius: Decorations.borderRadius8),
      ),
    );
  }
}
