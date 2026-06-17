import 'package:flutter/material.dart';

class AppClick extends StatefulWidget {
  final Widget child;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onLongPress;
  final GestureTapCallback? onDoubleTap;
  final String? toolTip ;
  final bool enabled ;
  const AppClick({required this.child,this.onLongPress ,this.enabled =true, this.onDoubleTap,this.toolTip ,this.onTap, super.key});
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
      onLongPress: widget.enabled? widget.onLongPress:null,
      onTap: widget.enabled?widget.onTap:null,
      onDoubleTap: widget.enabled?widget.onDoubleTap:null,
        behavior: HitTestBehavior.opaque,
        child: widget.child
    ) ;
  }
}
