import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/features/shop/cart/logic/validate_promo_cubit.dart';
import '../../../features/shop/shared/model/checkout_model.dart';
import '../../routes/routes.dart';
import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';
import '../../types/type_def.dart';
import '../app_button.dart';
import '../section_header.dart';
import 'info_box.dart';

class OrderDetailsCard extends StatelessWidget {
  final bool hasStatus;

  final bool hasAction;

  final String? title;

  const OrderDetailsCard({
    super.key,
    this.hasStatus = true,
    this.hasAction = true,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InfoBox(
      title: title == null ? null : SectionHeader(title: title!),
      header: hasStatus ? _buildHeader() : null,
      items: const [
        ("Order Number", "ORD0982631"),
        ("Purchase date", "19-11-2023"),
        ("Payment", "Pay at the Shop"),
        ("Estimated Delivery", "30-11-2023"),
      ],
      bottom: hasAction
          ? AppButton(
              text: "Details",
              buttonSize: null,
              onPressed: () => context.pushNamed(Routes.orderDetails),
            )
          : null,
    );
  }

  Widget _buildHeader() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text("Order Status", style: TextStyles.captionMedium),
      Text(
        "Packaging",
        style: TextStyles.labelSmall.copyWith(color: AppColors.primary),
      ),
    ],
  );
}

class OrderAddressInfoCard extends StatelessWidget {
  final bool hasAction;

  final String? title;

  const OrderAddressInfoCard({super.key, this.hasAction = true, this.title});

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
      bottom: hasAction
          ? const AppButton(text: "Change Address", buttonSize: null)
          : null,
    );
  }
}

class OrderShippingDateCard extends StatelessWidget {
  final bool hasAction;

  final String? title;

  const OrderShippingDateCard({super.key, this.hasAction = true, this.title});

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
      bottom: hasAction
          ? Text(
              "*Please double check the delivery address details before placing your order",
              style: TextStyles.bodySmall.copyWith(color: AppColors.primary),
            )
          : null,
    );
  }
}

class OrderReceiptCard extends StatelessWidget {
  final bool hasTitle;
  final CheckoutSummeryModel summery;

  const OrderReceiptCard({
    super.key,
    this.hasTitle = false,
    required this.summery,
  });

  @override
  Widget build(BuildContext context) {
    final promo = context.read<ValidatePromoCubit>().state.data?.couponInfo;
    final String? shipping = summery.shippingDisplay(promo);
    return Column(
      spacing: 2.h,
      children: [
        if (hasTitle) const SectionHeader(title: "Total Payment"),
        _buildPriceRow(("Subtotal", summery.subTotalDisplay), context),
        if (promo!=null)
          _buildPriceRow(
            (promo.code, summery.discountDisplay),
            context,
            titleColor: AppColors.success,
          ),

        if (shipping != null)
        _buildPriceRow(
          ("Shipping", shipping, ),
          context,

        ),

        if (summery.taxDisplay != null)
          _buildPriceRow(("TAX", summery.taxDisplay), context),

        Divider(height: 20.h),

        _buildPriceRow(
          ("Total", summery.totalDisplay),
          context,
          priceColor: AppColors.primary,
          titleColor: context.colors.surfaceContainerHighest,
        ),
      ],
    );
  }

  Widget _buildPriceRow(
      TitleAndSubtitle item,
      BuildContext context, {
        Color? priceColor,
        Color? titleColor,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          item.$1,
          style: TextStyles.bodyMedium.copyWith(
            color: titleColor ?? context.colors.surfaceContainer,
          ),
        ),
        Text(
          item.$2??"",
          style: TextStyles.labelMedium.copyWith(color: priceColor),
        ),
      ],
    );
  }
}