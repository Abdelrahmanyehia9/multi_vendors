part of 'product_filters_sheet.dart';

class _CategoryFilter extends _BaseFilter<CategoryModel> {
  const _CategoryFilter({required super.items, required super.selected});

  @override
  Widget buildItem(BuildContext context, CategoryModel category, List<CategoryModel> selectedValues) {
    return AppRadioButton<CategoryModel>(
      multiSelect: true,
      value: category,
      groupValue: selectedValues,
      onChanged: (_) => toggle(category),
      child: Row(
        spacing: 4.w,
        children: [
          CircularBox(radius: 30, child: AppCachedNetworkImage(category.img)),
          Text(category.name, style: TextStyles.labelMedium),
          if(category.count!=null && category.count!>0)
            Text("(${category.count})", style: TextStyles.labelMedium.copyWith(
              color: context.colors.surfaceContainer
            )),
        ],
      ),
    );
  }
}