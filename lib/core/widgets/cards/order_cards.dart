import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';

import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';
import '../../types/type_def.dart';
import '../app_button.dart';
import '../section_header.dart';
import 'info_box.dart';

class OrderDetailsCard extends StatelessWidget {
  final bool hasStatus ;
  final bool hasAction ;
  final String? title ;
  const OrderDetailsCard({super.key, this.hasStatus = true,this.hasAction =true , this.title});

  @override
  Widget build(BuildContext context) {
    return InfoBox(
      title:title == null ? null : SectionHeader(title: title!),
      header: hasStatus?_buildHeader() :null,
      items: const [
        ("Order Number","ORD0982631"),
        ("Purchase date", "19-11-2023"),
        ("Payment", "Pay at the Shop"),
        ("Estimated Delivery", "30-11-2023"),
      ],
      bottom:hasAction ?   AppButton(text: "Details",buttonSize: null, onPressed: ()=>context.pushNamed(Routes.orderDetails),) :null,

    );
  }
  Widget _buildHeader()=>Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text("Order Status", style: TextStyles.captionMedium,),
      Text("Packaging", style: TextStyles.labelSmall.copyWith(
          color: AppColors.primary
      ),
      )
    ],
  ) ;
}
class OrderAddressInfoCard extends StatelessWidget {
  final bool hasAction ;
  final String? title ;
  const OrderAddressInfoCard({super.key, this.hasAction = true, this.title});

  @override
  Widget build(BuildContext context) {
    return  InfoBox(
      title: title == null ? null : SectionHeader(title: title!),
      items: const [
        ("name", "Jessica"),
        ("Street", "123 Second Street NE"),
        ("Country/Region", "United States"),
        ("State/Provincie", "Washington"),
        ("Postal Code", "20500"),
      ],
      bottom:hasAction? const AppButton(text: "Change Address", buttonSize: null):null,
    );
  }
}
class OrderShippingDateCard extends StatelessWidget {
  final bool hasAction ;
  final String? title;
  const OrderShippingDateCard({super.key, this.hasAction =true, this.title});

  @override
  Widget build(BuildContext context) {
    return InfoBox(
      title: title == null ? null : SectionHeader(title: title!),
        items: const [
          ("name", "Jessica"),
          ("Street", "123 Second Street NE"),
          ("Country/Region", "United States"),
          ("State/Provincie", "Washington"),
          ("Postal Code", "20500"),
        ],
        bottom: hasAction?  Text("*Please double check the delivery address details before placing your order", style: TextStyles.bodySmall.copyWith(color: AppColors.primary),):null
    );
  }
}
class OrderReceiptCard extends StatelessWidget {
  final bool hasTitle ;
  const OrderReceiptCard({super.key, this.hasTitle = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 2.h,
      children: [
        if (hasTitle) const SectionHeader(title: "Total Payment"),
        _buildPriceRow(("Subtotal", "\$ 120.00"), context),
        _buildPriceRow(("Promo Voucher", "-\$ 12.00"), context),
        _buildPriceRow(("Shipping cost", "-\$ 6.00"), context),
        Divider(height: 20.h),
        _buildPriceRow(
            ("Total", "\$ 108.00"), context, priceColor: AppColors.primary , titleColor: context.colors.surfaceContainerHighest),
      ],
    );
  }

  Widget _buildPriceRow(TitleAndSubtitle item, BuildContext context,
      {Color? priceColor, Color? titleColor}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item.$1,
              style: TextStyles.bodyMedium.copyWith(
                  color: titleColor ?? context.colors.surfaceContainer)
          ),
          Text(item.$2!,
              style: TextStyles.labelMedium.copyWith(color: priceColor)),
        ],
      );
}

