import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_button.dart';
import 'package:multi_vendor/core/widgets/app_text_field.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';

import '../../../../core/widgets/gap.dart';
import '../../../../core/widgets/scaffold/base_scaffold.dart';

class ApplyPromoVoucher extends StatelessWidget {
  const ApplyPromoVoucher({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: "Promo Voucher"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Promo Code Voucher", style: TextStyles.headline3),
          Gap.small(),
          Text(
            "Enjoy a more special shopping experience with our exclusive vouchers! Get special discounts and take advantage of our attractive offers",
            style: TextStyles.captionMedium,
          ),
          Gap.huge(),
          const AppTextField(
            headerText: "Voucher Code",
            hintText: "Enter your voucher code",
          ),
          Gap.medium(),
          const AppButton(text: "Use this Voucher Code", buttonSize: null),
        ],
      ).appPaddingHr,
    );
  }
}
