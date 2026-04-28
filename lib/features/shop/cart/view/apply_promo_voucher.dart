import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/app_text_field.dart';
import 'package:multi_vendor/core/widgets/buttons/app_delete_button.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_model.dart';
import 'package:multi_vendor/features/shop/cart/data/models/promo_code_model.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/shared/view/widgets/message_alert.dart';
import 'package:multi_vendor/features/shop/cart/logic/validate_promo_cubit.dart';
class ApplyPromoVoucher extends StatefulWidget {
  const ApplyPromoVoucher({super.key});

  @override
  State<ApplyPromoVoucher> createState() => _ApplyPromoVoucherState();
}

class _ApplyPromoVoucherState extends State<ApplyPromoVoucher> {
  final _codeController = TextEditingController();
   List<CartModel>get  items => cartCubit.cartItems ;
   ValidatePromoCubit get cubit => context.read<ValidatePromoCubit>();

  Future<void>onSubmit()async{
    cubit.validatePromo(
      items: items,
      code: _codeController.text.trim().toUpperCase(),
    );
  }

   @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: "Promo Voucher", actions: [_buildAction()],),
      body: BaseBlocConsumer<ValidatePromoCubit, PromoCardResponse>(
        builder: (state) {
          final data = state.data;
          final isValid = data?.valid == true;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isValid) _buildSuccess(data) else _buildForm(state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSuccess(PromoCardResponse data) => MessageAlert(
      customTitle: data.message,
      MessagesAlertType.promoSuccess,
      customMessage: data.couponInfo?.message) ;
  Widget _buildForm(
      BaseState s,
      ) {
    final data = s.data;
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
          textCapitalization: TextCapitalization.characters,
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
            onPressed: onSubmit,
          ),
        ),
      ],
    );
  }
  Widget _buildAction() => BaseBlocConsumer<ValidatePromoCubit, PromoCardResponse>(
      successBuilder: (s){
        if(s.valid){
          return AppDeleteButton( onTap: cubit.reset,);
        }
        return const SizedBox.shrink();
      },
    );

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }
}
