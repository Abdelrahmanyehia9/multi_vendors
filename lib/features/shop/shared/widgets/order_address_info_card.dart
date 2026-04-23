import 'package:flutter/material.dart';

import '../../../../core/models/address_model.dart';
import '../../../../core/widgets/buttons/app_button.dart';
import '../../../../core/widgets/cards/info_box.dart';
import '../../../../core/widgets/section_header.dart';

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
        ("name", address.name),
        ("Street", address.street),
        ("Country/Region", address.country),
        ("State/Provincie", address.city),
        ("building / apartment / floor", "${address.buildNum} / ${address.aptNum} / ${address.floor??""}"),
        if(address.postalCode!=null)
        ("Postal Code", address.postalCode.toString()),
      ],
      bottom: hasAction
          ?  AppButton(
          onPressed: onActionTap,
          text: "Change Address", buttonSize: null)
          : null,
    );
  }
}
