import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_colors.dart';
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
            fontSize: 12.sp,
          ),
        ),
        Gap.extraSmall(),
        customBody ?? Text(
          body!,
          style: TextStyles.captionMedium.copyWith(
            color: AppColors.grey600,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
