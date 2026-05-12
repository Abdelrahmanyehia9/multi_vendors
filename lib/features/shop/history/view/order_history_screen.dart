import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/shop/history/logic/order_history_cubit.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/shared/data/models/action_model.dart';
import 'package:multi_vendor/shared/view/widgets/cards/order_cards.dart';
import 'package:multi_vendor/features/shop/shared/model/order_model.dart';
import 'package:multi_vendor/shared/view/widgets/login_required.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      paddingHr: 0,
      appBar: BaseAppBar(title: AppStrings.orderHistory.tr()),
      body: LoginRequired(
        child: BaseBlocConsumer<OrderHistoryCubit, List<OrderModel>>(
          successBuilder: (orders) => _buildOrderList(orders),
          failureBuilder: AppStates.error,
          emptyBuilder: () => AppStates.empty(
            message: AppStrings.noOrdersFound,
            actionModel: ActionModel(
              text: AppStrings.listProducts,
              action: (context) => context.pushNamed(Routes.products),
            ),
          ),
          loadingBuilder: () => _buildOrderList(
            List<OrderModel>.generate(5, (_) => OrderModel()),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderList(List<OrderModel> orders) => ListView.separated(
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    itemBuilder: (_, i) => OrderDetailsCard(order: orders[i]),
    separatorBuilder: (_, _) => Gap.medium(),
    itemCount: orders.length,
  );
}
