import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/buttons/app_icon_button.dart';
import 'package:multi_vendor/core/widgets/overlays/dialogues.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/core/widgets/scaffold/sticky_bottom_layout.dart';
import 'package:multi_vendor/features/shop/history/data/model/order_tracking_model.dart';
import 'package:multi_vendor/features/shop/history/logic/order_tracking_cubit.dart';
import 'package:multi_vendor/features/shop/history/view/widgets/order_captain_card.dart';
import 'package:multi_vendor/features/shop/history/view/widgets/order_tracking_timeline.dart';
import 'package:multi_vendor/features/shop/shared/model/order_model.dart';
import '../logic/helper/order_history_helper.dart';
import '../logic/order_cancel_cubit.dart';

class OrderTrackingScreen extends StatelessWidget {
  final int trackId;

  const OrderTrackingScreen({super.key, required this.trackId});

  void onRefresh(BuildContext context) {
    context.read<OrderTrackingCubit>().orderTracking(trackId);
  }

  void onCancelOrder(BuildContext context) {
    context.read<CancelOrderCubit>().cancelOrder(trackId);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      paddingHr: 0,
      appBar: BaseAppBar(
        title: "Order Tracking",
        actions: [
          AppIconButton(icon: Icons.refresh, onTap: () => onRefresh(context)),
        ],
      ),
      body: BaseBlocConsumer<OrderTrackingCubit, OrderTrackingModel>(
        successBuilder: (track) => _builder(track, context),
        loadingBuilder: () => _builder(OrderTrackingModel.fake(), context),
        failureBuilder: AppStates.error,
      ),
    );
  }

  Widget _builder(OrderTrackingModel model, BuildContext context) =>
      StickyBottomLayout(
        content: SingleChildScrollView(
          child: Column(
            spacing: 16,
            children: [
              OrderTrackingTimeLine(status: model.status),
              if (model.captain != null)
                OrderCaptainCard(captain: model.captain!),
            ],
          ),
        ),
        sticky: _CancelOrderButton(
          canCancel: model.canCancel,
          onCancel: () => onCancelOrder(context),
        ),
      );
}

class _CancelOrderButton extends StatelessWidget {
  final bool canCancel;

  final GestureTapCallback onCancel;

  const _CancelOrderButton({required this.canCancel, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<CancelOrderCubit, OrderModel>(
      onFailure: (e) => context.errorBar(message: e.message),
      onSuccess: (order) => OrderHistoryHelper.onSuccess(context, order: order!),
      builder: (s) => AppButton(
        text: "Cancel order",
        buttonSize: null,
        isLoading: s.isLoading,
        enabled: canCancel,
        onPressed: () async {
          await AppDialogues.showWarning(
            context,
            title: "Cancel Order",
            onConfirm: onCancel,
            message: "Are you sure you want to cancel this order?",
          );
        },
      ),
    );
  }
}
