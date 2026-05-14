import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/app_text_field.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/shared/logic/search_cubit.dart';


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
              const Gap(6),
            ],
            AppTextField(
              focusNode: cubit.focusNode,
              controller: cubit.controller,
              onTap: onTap,
              hintText: '${AppStrings.search.tr()} ....',
              hintStyle: TextStyles.captionLarge,
              borderType: AppBorderType.filled,
              padding: !state.hasFocus
                  ? EdgeInsets.zero
                  : EdgeInsets.symmetric(horizontal: 16.w),
              prefix: state.hasFocus ? null : const Icon(MvIcons.search),
            ),
          ],
        );
      },
    );
  }
}