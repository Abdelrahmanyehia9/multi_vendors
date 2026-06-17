import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/app_dismissable.dart';

class AppDeleteDismissable extends StatelessWidget {
  final Widget child;
  final GestureTapCallback? onDelete;

  const AppDeleteDismissable({
    required super.key,
    this.onDelete,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AppDismissable(
      key: key,
      onDismissed: (_) => onDelete?.call(),
      startAction: AppDismissAction(
        icon: MvIcons.delete,
        label: AppStrings.delete.tr(),
      ),
      child: child,
    );
  }

}
  // Future<bool> confirmDismiss(BuildContext context) async{
  //   bool confirm = false ;
  //   await Popups.showWarning(context, onConfirm: (){
  //     confirm = true;
  //   });
  //   return confirm;
  // }}