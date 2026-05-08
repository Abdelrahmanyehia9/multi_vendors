import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';

import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/features/shop/cart/logic/validate_promo_cubit.dart';

class AddVoucherTile extends StatelessWidget {
  const AddVoucherTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.pushNamed(Routes.promo , arguments: context.read<ValidatePromoCubit>()),
      contentPadding: EdgeInsets.zero,
      title: Text(AppStrings.promoCodeVoucher.tr(), style: TextStyles.labelMedium),
      subtitle: Text(AppStrings.useTheVoucherCodeProvided.tr(),
          style: TextStyles.bodySmall.copyWith(color: context.colors.surfaceContainer)),
      trailing: Icon(MvIcons.arrowForwardIos, size: 18.sp),
    );
  }
}
