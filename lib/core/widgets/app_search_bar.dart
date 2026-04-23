import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/search_cubit.dart';
import '../theme/text_styles.dart';
import 'app_text_field.dart';

class AppSearchbar extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Widget? title;
  final void Function(String?)? onSubmit;
  final void Function(String? query)? onQueryChanged;

  const AppSearchbar({
    super.key,
    this.onTap,
    this.title,
    this.onSubmit,
    this.onQueryChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {
       if(state.hasFocus) onQueryChanged?.call(state.query);
       if(!state.hasFocus) onSubmit?.call(cubit.controller.text);
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null&&!state.hasFocus) ...[
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