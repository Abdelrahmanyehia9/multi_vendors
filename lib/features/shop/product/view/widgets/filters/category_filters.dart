
part of 'product_filters_sheet.dart';



class _CategoryFilter extends StatelessWidget with _CategoryFilterMixin {
  @override final List<CategoryModel> items;
  @override final ValueNotifier<List<CategoryModel>> selected;

  const _CategoryFilter({required this.items, required this.selected});

  Widget _buildNode(BuildContext context, CategoryModel node, List<CategoryModel> selectedValues, int depth) {
    final children = _childrenOf(node);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 10.h,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: (depth * 16).w),
          child: AppClick(
            onTap: () => _toggle(node),
            child: Row(
              spacing: 10.w,
              children: [
                _CategoryCheckbox(
                  checked: _isFullySelected(node, selectedValues),
                  partial: _isPartial(node, selectedValues),
                ),
                if (depth == 0) CircularBox(radius: 30, child: AppCachedNetworkImage(node.img)),
                Expanded(child: Text(node.name, style: depth == 0 ? TextStyles.labelMedium : TextStyles.bodyMedium)),
                if ((node.count ?? 0) > 0)
                  Text("(${node.count})", style: TextStyles.labelSmall.copyWith(color: context.colors.surfaceContainer)),
              ],
            ),
          ),
        ),
        ...children.map((child) => _buildNode(context, child, selectedValues, depth + 1)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selected,
      builder: (context, selectedValues, _) {
        return Column(
          spacing: 12.h,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: roots.map((root) => _buildNode(context, root, selectedValues, 0)).toList(),
        );
      },
    );
  }
}

