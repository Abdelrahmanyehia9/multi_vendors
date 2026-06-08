import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/features/main/profile/data/model/address_model.dart';
import 'package:multi_vendor/shared/view/widgets/cards/info_box.dart';
import 'package:multi_vendor/shared/view/widgets/section_header.dart';

class OrderAddressInfoCard extends StatelessWidget {
  final bool hasAction;
  final AddressModel address;
  final String? title;
  final GestureTapCallback? onActionTap ;
  const OrderAddressInfoCard({super.key,this.onActionTap , required this.address , this.hasAction = true, this.title});

  @override
  Widget build(BuildContext context) {
    return InfoBox(
      title: title == null ? null : SectionHeader(title: title!),
      items:  [
        if(address.name!=null)
        (AppStrings.name.tr(), address.name, child: null),
        (AppStrings.street.tr(), address.street, child: null),
        ("${AppStrings.country.tr()}/${AppStrings.region.tr()}", address.country, child: null),
        ("${AppStrings.state.tr()}/${AppStrings.province.tr()}", address.city, child:  null),
        ("${AppStrings.building.tr()} / ${AppStrings.apartment.tr()} / ${AppStrings.floor.tr()}", "${address.buildNum} / ${address.aptNum} / ${address.floor??""}", child: null),
        if(address.postalCode!=null)
        (AppStrings.postalCode.tr(), address.postalCode.toString(), child:  null),
      ],
      bottom: hasAction
          ?  AppButton(
          onPressed: onActionTap,
          text: AppStrings.changeAddress.tr(), buttonSize: null)
          : null,
    );
  }
}
