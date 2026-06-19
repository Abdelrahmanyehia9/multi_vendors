import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';

class SelectionModeHeader extends StatelessWidget {
  final bool isSelectionMode ;
  final int count ;
  final bool isAllSelected ;
  final GestureTapCallback? onSelectAll;
  final GestureTapCallback? onUnselectAll ;
  const SelectionModeHeader({
    super.key,
    required this.isSelectionMode,
    required this.count,
    required this.isAllSelected,
    this.onSelectAll,
    this.onUnselectAll,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isSelectionMode,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$count ${AppStrings.itemSelected.tr()}"),
          AppButton.text(
            text: isAllSelected ? AppStrings.unSelectAll.tr() : AppStrings.selectAll.tr(),
            onPressed: isAllSelected
                ? onUnselectAll
                : onSelectAll,
            padding: EdgeInsets.zero,
            fixedSize: const Size(100, 20),
            style: TextStyles.labelSmall.copyWith(color: context.colors.primary),
          ),
        ],
      ),
    );
  }
}
