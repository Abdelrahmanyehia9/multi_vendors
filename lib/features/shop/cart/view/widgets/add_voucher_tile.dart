import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';

import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/features/shop/cart/logic/validate_promo_cubit.dart';

class AddVoucherTile extends StatelessWidget {
  const AddVoucherTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.pushNamed(Routes.promo , arguments: context.read<ValidatePromoCubit>()),
      contentPadding: EdgeInsets.zero,
      title: Text("Promo Code Voucher", style: TextStyles.labelMedium),
      subtitle: Text("Use the Voucher Code provided",
          style: TextStyles.bodySmall.copyWith(color: context.colors.surfaceContainer)),
      trailing: Icon(Icons.arrow_forward_ios, size: 18.sp),
    );
  }
}
