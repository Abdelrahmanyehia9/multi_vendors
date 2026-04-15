import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/search_cubit.dart';
import '../theme/app_colors.dart';
import '../theme/text_styles.dart';
import 'app_text_field.dart';

class AppSearchbar extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Widget? title;
  final void Function(String? query)? onQueryChanged;

  const AppSearchbar({
    super.key,
    this.onTap,
    this.title,
    this.onQueryChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {
        onQueryChanged?.call(state.query);
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              title!,
              SizedBox(height: 8.h),
            ],
            AppTextField(
              focusNode: cubit.focusNode,
              controller: cubit.controller,
              onTap: onTap,
              hintText: 'Search',
              hintStyle: TextStyles.captionMedium,
              borderType: AppBorderType.filled,
              padding: !state.hasFocus
                  ? EdgeInsets.zero
                  : EdgeInsets.symmetric(horizontal: 16.w),
              prefix: state.hasFocus ? null : const Icon(Icons.search),
            ),
          ],
        );
      },
    );
  }
}