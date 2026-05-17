part of 'product_filters_sheet.dart';

class _CategoryFilter extends StatelessWidget with _CategoryFilterMixin {
  @override
  final List<CategoryModel> items;
  @override
  final ValueNotifier<List<CategoryModel>> selected;
  const _CategoryFilter({required this.items, required this.selected});


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selected,
      builder: (context, selectedValues, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: roots
              .map((root) => _buildNode(context, root, selectedValues, 0))
              .toList(),
        );
      },
    );
  }
  Widget _buildNode(
      BuildContext context,
      CategoryModel node,
      List<CategoryModel> selectedValues,
      int depth,
      ) {
    final children = _childrenOf(node);
    return Padding(
      padding: EdgeInsetsDirectional.only(start: (depth * 16).w),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        minTileHeight: 0,
        childrenPadding: EdgeInsets.zero,
        trailing: children.isEmpty ? const SizedBox() : null,
        leading: AppClick(
          onTap: () => _toggle(node),
          child: _CategoryCheckbox(
            checked: _isFullySelected(node, selectedValues),
            partial: _isPartial(node, selectedValues),
          ),
        ),
        title: Row(
          spacing: 10.w,
          children: [
            if (depth == 0)
              CircularBox(radius: 30, child: AppCachedNetworkImage(node.img)),
            Expanded(
              child: Text(
                node.name.localized,
                style: depth == 0
                    ? TextStyles.labelMedium
                    : TextStyles.bodyMedium,
              ),
            ),
            if ((node.count ?? 0) > 0)
              Text(
                "(${node.count})",
                style: TextStyles.labelSmall.copyWith(
                  color: context.colors.surfaceContainer,
                ),
              ),
          ],
        ),
        children: children
            .map(
              (child) => _buildNode(context, child, selectedValues, depth + 1),
        )
            .toList(),
      ),
    );
  }

}
