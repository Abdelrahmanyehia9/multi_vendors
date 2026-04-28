import 'dart:math';
import 'package:flutter/material.dart';

import 'package:multi_vendor/core/theme/app_colors.dart';

class RangeSliderWidget extends StatefulWidget {
  final double min;
  final double max;
  final ValueNotifier<RangeValues?> rangeNotifier;

  const RangeSliderWidget({
    super.key,
    required this.min,
    required this.max,
    required this.rangeNotifier,
  });

  @override
  State<RangeSliderWidget> createState() => _RangeSliderWidgetState();
}

class _RangeSliderWidgetState extends State<RangeSliderWidget> {
  final List<double> _bars = List.generate(30, (_) => 0.15 + Random().nextDouble() * 0.85);

  _ActiveThumb? _activeThumb;

  double get _total => widget.max - widget.min;

  RangeValues get _displayRange => widget.rangeNotifier.value ?? RangeValues(widget.min, widget.max);

  double _toValue(double x, double width) =>
      ((x / width) * _total + widget.min).clamp(widget.min, widget.max);

  double _toX(double value, double width) => (value - widget.min) / _total * width;

  void _onStart(double x, double width) {
    final range = _displayRange;
    final startX = _toX(range.start, width);
    final endX = _toX(range.end, width);
    _activeThumb = (x - startX).abs() <= (x - endX).abs() ? _ActiveThumb.start : _ActiveThumb.end;
    _moveTo(x, width);
  }

  void _moveTo(double x, double width) {
    final value = _toValue(x, width);
    final range = _displayRange;
    widget.rangeNotifier.value = _activeThumb == _ActiveThumb.start
        ? RangeValues(value.clamp(widget.min, range.end - 1), range.end)
        : RangeValues(range.start, value.clamp(range.start, widget.max));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      return ValueListenableBuilder<RangeValues?>(
        valueListenable: widget.rangeNotifier,
        builder: (_, value, __) {
          final range = value ?? RangeValues(widget.min, widget.max);
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (d) => _onStart(d.localPosition.dx, width),
            onHorizontalDragStart: (d) => _onStart(d.localPosition.dx, width),
            onHorizontalDragUpdate: (d) => _moveTo(d.localPosition.dx, width),
            onHorizontalDragEnd: (_) => _activeThumb = null,
            child: SizedBox(
              height: 50,
              width: width,
              child: CustomPaint(
                painter: _BarsPainter(
                  bars: _bars,
                  startFraction: (range.start - widget.min) / _total,
                  endFraction: (range.end - widget.min) / _total,
                  activeColor: AppColors.primary,
                  inactiveColor: AppColors.grey300,
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
enum _ActiveThumb { start, end }

class _BarsPainter extends CustomPainter {
  final List<double> bars;
  final double startFraction;
  final double endFraction;
  final Color activeColor;
  final Color inactiveColor;

  const _BarsPainter({
    required this.bars,
    required this.startFraction,
    required this.endFraction,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final count = bars.length;
    final step  = size.width / count;
    final barW  = step * 0.5;

    for (int i = 0; i < count; i++) {
      final fraction = i / count;
      final isActive = fraction >= startFraction && fraction < endFraction;
      final barH     = bars[i] * size.height;
      final left     = i * step + (step - barW) / 2;
      final top      = size.height - barH;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(left, top, barW, barH),
          const Radius.circular(2),
        ),
        Paint()..color = isActive ? activeColor : inactiveColor,
      );
    }
  }

  @override
  bool shouldRepaint(_BarsPainter old) =>
      old.startFraction != startFraction || old.endFraction != endFraction;
}