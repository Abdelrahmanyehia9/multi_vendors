import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/buttons/app_delete_button.dart';
import 'package:multi_vendor/core/widgets/overlays/dialogues.dart';
import 'package:multi_vendor/features/shop/history/logic/order_delete_cubit.dart';
import 'package:multi_vendor/features/shop/history/view/widgets/order_details_actions.dart';
import 'package:multi_vendor/features/shop/shared/widgets/checkout_list_porducts.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/shared/view/widgets/cards/order_cards.dart';
import 'package:multi_vendor/features/shop/shared/model/order_model.dart';
import 'package:multi_vendor/features/shop/shared/widgets/order_address_info_card.dart';
import 'package:multi_vendor/features/shop/shared/widgets/order_recipt_card.dart';
import 'package:multi_vendor/features/shop/history/logic/helper/order_history_helper.dart';
import 'package:multi_vendor/features/shop/history/logic/order_details_cubit.dart';

class OrderDetailsScreen extends StatelessWidget {
  final int orderId ;
  const OrderDetailsScreen({super.key, required this.orderId}  );

  Future<void> onDeleteOrder(BuildContext context) async {
    context.read<OrderDeleteCubit>().deleteOrder(orderId);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: AppStrings.orderDetails.tr(),
        actions: [
          BaseBlocConsumer<OrderDeleteCubit, OrderModel>(
            onSuccess: (order) => OrderHistoryHelper.onOrderActionSuccess(context, order: order!,isDelete: true),
            onFailure: (e) => context.errorBar(message:  e.message),
            builder: (_) => _buildDeleteOrder(context, () => onDeleteOrder(context)),
          ),
        ],
      ),
      body: BaseBlocConsumer<OrderDetailsCubit, OrderModel>(
        successBuilder: (order) => _buildOrderDetails(order),
        loadingBuilder: () => _buildOrderDetails(OrderModel.fake()),
      ),
    );
  }

  Widget _buildOrderDetails(OrderModel order) => SingleChildScrollView(
    child: Column(
      spacing: 16.h,
      children: [
        OrderDetailsCard(
          hasAction: false,
          showOrderItems: false,
          title: AppStrings.orderDetails.tr(),
          order: order,
        ),
        if (order.address != null)
          OrderAddressInfoCard(
            hasAction: false,
            title: AppStrings.shippingAddress.tr(),
            address: order.address!,
          ),
        CheckoutListProducts(showHeader: true, items: order.items!),
        OrderReceiptCard(hasTitle: true, summery: order.summery!),
        OrderDetailsActions(order: order),
      ],
    ),
  );

  Widget _buildDeleteOrder(
    BuildContext context,
    GestureTapCallback? onDelete,
  ) => BaseBlocConsumer<OrderDetailsCubit, OrderModel>(
    successBuilder: (order) => order.canDelete
        ? AppDeleteButton(
            onTap: () {
              Popups.showWarning(
                context,
                title: AppStrings.deleteOrder,
                onConfirm: onDelete,
                message: AppStrings.deleteOrderMessage,
              );
            },
          )
        : const SizedBox.shrink(),
    loadingBuilder: () => const AppDeleteButton(),
  );
}
