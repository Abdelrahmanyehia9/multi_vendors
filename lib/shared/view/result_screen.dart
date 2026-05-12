import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';

import 'package:multi_vendor/shared/view/widgets/message_alert.dart';

class ResultScreenArgs {
  final MessagesAlertType type ;
  final String? customMessage ;
  final String? customTitle;
  final Widget? customIcon;
  final Widget Function(BuildContext)? action ;
  const ResultScreenArgs({required this.type, this.customIcon, this.customMessage, this.action, this.customTitle });
}


class ResultScreen extends StatelessWidget {
  final ResultScreenArgs args ;
  const ResultScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(),
      body: Column(
        spacing: 8.h,
        children: [
          MessageAlert(
            customIcon: args.customIcon,
              customTitle: args.customTitle,
              customMessage: args.customMessage,
              args.type),
          if(args.action != null) args.action!.call(context),

        ],
      ),
    );
  }
}
