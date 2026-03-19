import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import '../../../../../../core/theme/text_styles.dart';
import '../../../../../../core/widgets/gap.dart';

class ProductInfoSection extends StatelessWidget {
  final String header;
  final String? body;
  final Widget? customBody;
  const ProductInfoSection({
    super.key,
    required this.header,
    this.body,
    this.customBody,
  });

  @override
  Widget build(BuildContext context) {
    assert(body != null || customBody != null);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style:
          TextStyles.labelMedium.copyWith(
            fontWeight: FontWeightHelper.black,
            fontSize: 14.sp,
          ),
        ),
        Gap.extraSmall(),
        customBody ?? Text(
          body!,
          style: TextStyles.captionMedium.copyWith(
            color: context.colors.surfaceContainerHigh,
            fontSize: 13.sp,
          ),
        ),
      ],
    );
  }
}
