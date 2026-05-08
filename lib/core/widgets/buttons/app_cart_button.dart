import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/buttons/app_icon_button.dart';

class AppCartButton extends StatelessWidget {
  const AppCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer(
      bloc: cartCubit,
      builder:(_) {
        final int? count = cartCubit.state.data?.length;
        return Badge(
          isLabelVisible: count != null && count > 0,
          label: Text(count?.toString() ?? '', style: TextStyles.labelSmall),
          child:  AppIconButton(
              tooltip: AppStrings.myCart,
              icon: MvIcons.shopping, onTap: () => context.pushNamed(Routes.cart)),
        );
      },
    );
  }
}
