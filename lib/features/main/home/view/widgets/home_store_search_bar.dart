import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/widgets/app_text_field.dart';

class HomeStoreSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final GestureTapCallback? onTap;

  const HomeStoreSearchBar({
    super.key,
    this.focusNode,
    this.onTap,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (focusNode == null) return _buildColumn();

    return ListenableBuilder(
      listenable: focusNode!,
      builder: (context, _) => _buildColumn(),
    );
  }

  Widget _buildColumn() {
    bool hasFocus= focusNode == null || !focusNode!.hasFocus ;
    return Column(
      spacing: 8.sp,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasFocus)
          Text.rich(
            TextSpan(
              text: "Discover Your Best ",
              style: TextStyles.labelLarge,
              children: [
                TextSpan(
                  text: "Fashion !",
                  style: TextStyles.labelLarge.copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ),
        AppTextField(
          focusNode: focusNode,
          hintText: 'Search',
          padding: hasFocus ?  EdgeInsets.zero : EdgeInsets.symmetric(horizontal: 16.w),
          borderType: AppBorderType.filled,
          controller: controller,
          onTap: onTap,
          hintStyle: TextStyles.captionMedium,
          prefix: !hasFocus? null :  const Icon(Icons.search),
        ),
      ],
    );
  }
}