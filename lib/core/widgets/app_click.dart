import 'package:flutter/material.dart';

class AppClick extends StatefulWidget {
  final Widget child;
  final GestureTapCallback? onTap;
  final String? toolTip ;
  const AppClick({required this.child,this.toolTip ,this.onTap, super.key});
  @override
  State<AppClick> createState() => _AppClickState();
}
class _AppClickState extends State<AppClick> {

  @override
  Widget build(BuildContext context) {
    if(widget.toolTip==null)return _buildClick();
    return Tooltip(
      message: widget.toolTip,
      child: _buildClick(),
    );
  }
  Widget _buildClick (){
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: widget.child
    ) ;
  }
}
