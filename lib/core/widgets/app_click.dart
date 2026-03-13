import 'package:flutter/material.dart';

class AppClick extends StatefulWidget {
  final Widget child;
  final GestureTapCallback? onTap;
  const AppClick({required this.child, this.onTap, super.key});
  @override
  State<AppClick> createState() => _AppClickState();
}
class _AppClickState extends State<AppClick> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      child: widget.child
    );
  }
}
