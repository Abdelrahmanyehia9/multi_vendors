part of 'product_filters_sheet.dart';

mixin _CategoryFilterMixin {
  List<CategoryModel> get items;
  ValueNotifier<List<CategoryModel>> get selected;

  List<CategoryModel> get roots => items.where((c) => c.parent == null).toList();
  List<CategoryModel> _childrenOf(CategoryModel node) => items.where((c) => c.parent == node.id).toList();
  List<CategoryModel> _descendantsOf(CategoryModel node) {
    final children = _childrenOf(node);
    return [...children, ...children.expand(_descendantsOf)];
  }

  void _toggle(CategoryModel node) {
    final descendants = _descendantsOf(node);
    final current = [...selected.value];
    final allSelected = current.contains(node) && descendants.every(current.contains);

    if (allSelected) {
      current..remove(node)..removeWhere(descendants.contains);
    } else {
      current.addAll([node, ...descendants].where((c) => !current.contains(c)));
    }

    // sync ancestors
    var parentId = node.parent;
    while (parentId != null) {
      final parent = items.firstWhere((c) => c.id == parentId);
      _childrenOf(parent).every(current.contains) ? current.add(parent) : current.remove(parent);
      parentId = parent.parent;
    }

    selected.value = current;
  }

  bool _isFullySelected(CategoryModel node, List<CategoryModel> current) {
    final descendants = _descendantsOf(node);
    return current.contains(node) && descendants.every(current.contains);
  }

  bool _isPartial(CategoryModel node, List<CategoryModel> current) {
    return _descendantsOf(node).any(current.contains) && !_isFullySelected(node, current);
  }
}


