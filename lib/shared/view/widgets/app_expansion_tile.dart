import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/context.dart';

class AppExpansionTile extends StatelessWidget {
  final Widget? title;

  final bool initiallyExpanded;

  final Widget? child;

  const AppExpansionTile({
    super.key,
    this.initiallyExpanded = true,
    this.title,
     this.child
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: initiallyExpanded,
      childrenPadding: EdgeInsets.zero,
      tilePadding: EdgeInsets.zero,
      iconColor: context.colors.surfaceContainerHigh,
      title: title ?? const SizedBox(),
      children: [SizedBox(width: double.infinity, child: child)],
    );
  }
}
