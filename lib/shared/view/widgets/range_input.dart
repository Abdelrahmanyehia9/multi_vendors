import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/gap.dart';

import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_text_field.dart';
import 'package:multi_vendor/shared/view/widgets/range_slider.dart';

enum RangeInputType { textField, wheel }

class RangeInput extends StatefulWidget {
  final String? header;
  final RangeInputType type;
  final RangeValues range;
  final ValueNotifier<RangeValues?> rangeNotifier;

  const RangeInput({
    super.key,
    this.header,
    this.type = RangeInputType.textField,
    required this.range,
    required this.rangeNotifier,
  });

  @override
  State<RangeInput> createState() => _RangeInputState();
}

class _RangeInputState extends State<RangeInput> {
  late final TextEditingController _fromController;
  late final TextEditingController _toController;

  double get min => widget.range.start;
  double get max => widget.range.end;
  @override
  void initState() {
    super.initState();
    _fromController = TextEditingController(text: widget.range.start.toStringAsFixed(0));
    _toController = TextEditingController(text: widget.range.end.toStringAsFixed(0));
    _setupControllers();
    widget.rangeNotifier.addListener(_syncFromRangeNotifier);
  }

  void _setupControllers() {
    _fromController.addListener(() {
      final value = double.tryParse(_fromController.text);
      if (value == null) return;
      final current = widget.rangeNotifier.value ?? widget.range;
      final newStart = value.clamp(min, current.end);
      if (newStart != current.start) {
        widget.rangeNotifier.value = RangeValues(newStart, current.end);
      }
    });

    _toController.addListener(() {
      final value = double.tryParse(_toController.text);
      if (value == null) return;
      final current = widget.rangeNotifier.value ?? widget.range;
      final newEnd = value.clamp(current.start, max);
      if (newEnd != current.end) {
        widget.rangeNotifier.value = RangeValues(current.start, newEnd);
      }
    });
  }

  void _syncFromRangeNotifier() {
    final r = widget.rangeNotifier.value ?? widget.range;
    final start = r.start.toStringAsFixed(0);
    final end = r.end.toStringAsFixed(0);
    if (_fromController.text != start) {
      _fromController.value = TextEditingValue(
        text: start,
        selection: TextSelection.collapsed(offset: start.length),
      );
    }
    if (_toController.text != end) {
      _toController.value = TextEditingValue(
        text: end,
        selection: TextSelection.collapsed(offset: end.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.header != null)
          Text(widget.header!, style: TextStyles.labelMedium),
        if (widget.type == RangeInputType.wheel)
          RangeSliderWidget(
            min: min,
            max: max,
            rangeNotifier: widget.rangeNotifier,
          ),
        Gap.tiny(),
        Row(
          spacing: 12.w,
          children: [
            _field(hint: AppStrings.from.tr(), controller: _fromController),
            _field(hint: AppStrings.to.tr(), controller: _toController),
          ],
        ),
      ],
    );
  }

  Widget _field({required String hint, required TextEditingController controller}) {
    return Expanded(
      child: AppTextField(
        hintText: hint,
        controller: controller,
        padding: EdgeInsets.zero,
        keyboardType: TextInputType.number,
        formatter: [
          FilteringTextInputFormatter.digitsOnly,
          MaxValueFormatter(max),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.rangeNotifier.removeListener(_syncFromRangeNotifier);
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }
}

class MaxValueFormatter extends TextInputFormatter {
  final double max;
  MaxValueFormatter(this.max);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;
    final value = double.tryParse(newValue.text);
    if (value == null || value > max) return oldValue;
    return newValue;
  }
}