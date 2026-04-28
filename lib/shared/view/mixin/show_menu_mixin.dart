import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/context.dart';

mixin ShowMenuMixin<T> {
  void showPopupMenu({
    required BuildContext context,
    required GlobalKey key,
    required List<PopupMenuEntry<T>> items,
    void Function(T value)? onSelected,
    double verticalOffset = 4,
  }) {
    final RenderBox renderBox =
    key.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    showMenu<T>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + size.height + verticalOffset,
        offset.dx + size.width,
        offset.dy + size.height + verticalOffset + 200,
      ),
      items: items,
      color: context.scaffoldBackground,
      shadowColor: context.colors.surfaceContainerLow
    ).then((value) {
      if (value != null) onSelected?.call(value);
    });
  }
}