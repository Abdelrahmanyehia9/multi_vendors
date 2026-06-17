import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/widget.dart';

class BaseScaffold extends StatelessWidget {
  final Widget? body;

  final Widget? bottomNavigationBar;

  final bool topSafeArea , bottomSafeArea;
  final PreferredSizeWidget? appBar;

  final double paddingHr;

  final double paddingVr;

  final Color? backgroundColor;

  const BaseScaffold({
    super.key,
    this.backgroundColor,
    this.paddingHr = 16,
    this.paddingVr = 16,
    this.topSafeArea = false,
    this.bottomSafeArea = true,
    this.appBar,
    this.body,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      body: _buildBody(context)?.paddingHr(paddingHr).paddingVr(paddingVr),
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  Widget? _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
         bottom: bottomSafeArea ? context.bottomSafeArea:0,
          top: topSafeArea  ? context.topSafeArea : 0),
      child: body ?? const SizedBox.shrink(),
    );
  }
}
