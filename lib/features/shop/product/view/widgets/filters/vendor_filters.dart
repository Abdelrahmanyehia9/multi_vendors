part of 'product_filters_sheet.dart';

class _VendorFilters extends _BaseFilter<VendorModel> {
  const _VendorFilters({required super.items, required super.selected});

  @override
  Widget buildItem(BuildContext context, VendorModel vendor, List<VendorModel> selectedValues) {
    return AppRadioButton<VendorModel>(
      multiSelect: true,
      value: vendor,
      groupValue: selectedValues,
      onChanged: (_) => toggle(vendor),
      child: Row(
        spacing: 4.w,
        children: [
          AppCachedNetworkImage(vendor.image,width: 24,radius: Decorations.borderRadius8,),
          Text(vendor.name, style: TextStyles.labelMedium),
          if(vendor.count!=null && vendor.count!>0)
            Text("(${vendor.count})", style: TextStyles.labelMedium.copyWith(
              color: context.colors.surfaceContainer
            )),
        ],
      ),
    );
  }
}
