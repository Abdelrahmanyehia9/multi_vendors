import 'package:flutter/material.dart';

import 'package:multi_vendor/shared/view/widgets/app_expansion_tile.dart';
import 'package:multi_vendor/shared/view/widgets/section_header.dart';

class CheckoutExpansionTile extends StatelessWidget {
  final String title;
  final Widget content;
  final bool initiallyExpanded;

  const CheckoutExpansionTile(
      this.title,
      this.content, {
        super.key,
        this.initiallyExpanded = true,
      });

  @override
  Widget build(BuildContext context) {
    return AppExpansionTile(
      initiallyExpanded: initiallyExpanded,
      title: SectionHeader(title: title),
      child: content,
    );
  }
}
