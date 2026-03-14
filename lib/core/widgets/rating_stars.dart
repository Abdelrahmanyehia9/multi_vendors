import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import '../theme/app_colors.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double size;
  final int? count;

  const RatingStars({
    super.key,
    this.count,
    required this.rating,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Row(

      children: [
        ...List.generate(5, (i) => _buildStar(i, context)),
        if (count != null && count! > 0) ...[
          Gap.extraSmall(),
          Text(
            "($count)",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.bodySmall.copyWith(
              color: context.colors.surfaceContainer,
              fontSize: (size - 6).sp,
            ),
          ),
        ]
      ],
    );
  }

  Widget _buildStar(int i, BuildContext context) {
    final full = i < rating.floor();
    final half = !full && i < rating && (rating - rating.floor()) >= 0.5;

    return Icon(
      full ? Icons.star : half ? Icons.star_half : Icons.star_border,
      size: size.sp,
      color: full || half
          ? AppColors.warning500
          : context.colors.surfaceContainer,
    );
  }
}