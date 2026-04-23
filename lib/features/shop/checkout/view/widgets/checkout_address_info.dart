import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import '../../../../../core/DI/setup_get_it.dart';
import '../../../../../core/models/address_model.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/utils/helper/app_validation.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../shared/widgets/order_address_info_card.dart';
import 'checkout_expansion_tile.dart';


class CheckoutAddressInfo extends StatelessWidget {
  const CheckoutAddressInfo({super.key});

  void _onAddressChange(BuildContext context) {
    context.pushNamed(Routes.editProfile);
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder(
      bloc:  userCubit,
      builder:(_,__) {
        final AddressModel? address = userCubit.user?.address ;
        if(address == null){
          return  AppTextField(readOnly: true,
            onTap:()=> _onAddressChange(context),
            autoValidateMode: AutovalidateMode.disabled,
            hintText: "Add Address",
            validator:(v)=> AppValidation.validateRequired(v, fieldName: "Address"),
          );
        }
        return  CheckoutExpansionTile("Shipping Address", OrderAddressInfoCard(address: address,
          onActionTap: ()=> _onAddressChange(context),
        )
        );
      },
    );
  }


}
