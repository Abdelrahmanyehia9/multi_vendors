import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_button.dart';
import 'package:multi_vendor/core/widgets/app_text_field.dart';
import 'package:multi_vendor/core/widgets/message_alert.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_model.dart';
import 'package:multi_vendor/features/shop/cart/data/models/promo_code_model.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/cubit/base_state.dart';
import '../../../../core/widgets/gap.dart';
import '../../../../core/widgets/scaffold/base_scaffold.dart';
import '../logic/cart_cubit.dart';
import '../logic/validate_promo_cubit.dart';
class ApplyPromoVoucher extends StatefulWidget {
  const ApplyPromoVoucher({super.key});

  @override
  State<ApplyPromoVoucher> createState() => _ApplyPromoVoucherState();
}

class _ApplyPromoVoucherState extends State<ApplyPromoVoucher> {
  final _codeController = TextEditingController();
   List<CartModel>get  items => context.read<CartCubit>().state.data ?? []  ;
   ValidatePromoCubit get cubit => context.read<ValidatePromoCubit>();

  @override
  Widget build(BuildContext context) {

    return BaseScaffold(
      appBar: BaseAppBar(title: "Promo Voucher", actions: [_buildAction()],),
      body: BaseBlocConsumer<ValidatePromoCubit, PromoCardResponse>(
        builder: (s) {
          final data = s.data;
          final isValid = data?.valid == true;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isValid) _buildSuccess(data!) else _buildForm(s, data,),
            ],
          );
        },
        onSuccess: (v){
          if(!v!.valid && !v.message.isNullOrEmpty) context.errorBar(message: v.message!) ;
        },
      ),
    );
  }

  Widget _buildSuccess(PromoCardResponse data, ) {
    return MessageAlert(
      customTitle: data.message,
      MessagesAlertType.promoSuccess,
      customMessage: data.couponInfo?.message,
    );
  }

  Widget _buildForm(
      BaseState s,
      PromoCardResponse? data,
      ) {
    final hasError = s.isSuccess && data?.valid == false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Promo Code Voucher", style: TextStyles.headline3),
        Gap.small(),
        Text(
          "Enjoy a more special shopping experience with our exclusive vouchers!",
          style: TextStyles.captionMedium,
        ),
        Gap.huge(),
        AppTextField(
          validator: (val){
            if(hasError) return data?.message ;
            return null ;
          },
          controller: _codeController,
          headerText: "Voucher Code",
          hintText: "Enter your voucher code",
        ),

        Gap.medium(),
        Skeletonizer(
          enabled: s.isLoading,
          child: AppButton(
            text: "Use this Voucher Code",
            buttonSize: null,
            onPressed: () {
              cubit.validatePromo(
                items: items,
                code: _codeController.text.trim(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAction(){
    return BaseBlocConsumer<ValidatePromoCubit, PromoCardResponse>(
      successBuilder: (s){
        if(s.valid){
          return AppIconButton(icon: Icons.delete, onTap: cubit.reset,);
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }
}
