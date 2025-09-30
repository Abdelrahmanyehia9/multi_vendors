import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TapAnimated extends StatefulWidget {
  final Widget child;
  final GestureTapCallback? onTap;

  const TapAnimated({required this.child, this.onTap, super.key});

  @override
  State<TapAnimated> createState() => _TapAnimatedState();
}
class _TapAnimatedState extends State<TapAnimated> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: widget.child
          .animate(target: _isPressed ? 1 : 0)
          .scaleXY(begin: 1, end: 0.95, duration: 100.ms, curve: Curves.linear)
          .fade(begin: 1.0, end: 0.85, duration: 100.ms, curve: Curves.linear),
    );
  }
}
