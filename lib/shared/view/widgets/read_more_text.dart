import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';

class ReadMoreText extends StatefulWidget {
  final String text;
  final int maxLength;
  final TextStyle? style;
  final String readMoreText;
  final String readLessText;

  const ReadMoreText({
    super.key,
    required this.text,
    this.maxLength = 100,
    this.style,
    this.readMoreText = "Read more",
    this.readLessText = "Read less",
  });

  @override
  State<ReadMoreText> createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final isLong = widget.text.length > widget.maxLength;

    final text = expanded || !isLong
        ? widget.text
        : widget.text.substring(0, widget.maxLength).trim();

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      children: [
        Text(
          expanded ? text : "$text... ",
          style: widget.style,
        ),
        if (isLong)
          AppClick(
            onTap: () => setState(() => expanded = !expanded),
            child: Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(
                expanded
                    ? widget.readLessText
                    : widget.readMoreText,
                style: widget.style?.copyWith(
                  color: AppColors.primary,
                ) ??

                    const TextStyle(
                      color: AppColors.primary,
                    ),
              ),
            ),
          ),
      ],
    );
  }
}