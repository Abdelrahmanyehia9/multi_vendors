part of 'product_filters_sheet.dart';

class _TagsFilters extends StatelessWidget {
  final List<ProductTagModel> tags;
  final ValueNotifier<List<ProductTagModel>> selectedTags;

  const _TagsFilters({required this.tags, required this.selectedTags});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedTags,
      builder: (context, value, child) {
        return Wrap(
            spacing: 4.w,
            runSpacing: 4.h,
            children: tags.map((e) => AppClick(
          onTap: () => _toggle(e),
          child: AppChip(
            unselectedColor: Colors.transparent,
            selectedColor: AppColors.primary,
              text: e.name,
             selected: value.contains(e),
          ),
        )).toList());
      }
    );
  }

  void _toggle(ProductTagModel tag) {
    final current = List<ProductTagModel>.from(selectedTags.value);
    current.contains(tag) ? current.remove(tag) : current.add(tag);
    selectedTags.value = current;
  }
}
