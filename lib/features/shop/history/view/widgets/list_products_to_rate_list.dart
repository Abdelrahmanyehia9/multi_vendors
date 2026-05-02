import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_model.dart';
import 'package:multi_vendor/features/shop/history/view/rate_product_screen.dart';
import 'package:multi_vendor/features/shop/shared/widgets/checkout_list_porducts.dart';

class ListProductsToRateList extends StatelessWidget {
  final bool shrinkWrap;
  final List<CartModel> items;

  const ListProductsToRateList({
    super.key,
    required this.items,
    this.shrinkWrap = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      itemBuilder: (_, i) {
        final bool isRated = items[i].isRated ?? false;
        return CheckoutProductCard(
          item: items[i],
          onTap: () => !isRated
              ? context.pushNamed(
                  Routes.rateProduct,
                  arguments: RateProductScreensArgs(
                    items: items.where((e) => e.isRated!=true).toList(),
                    initialItem: i,
                  ),
                )
              : null,
          customAction: _buildAction(isRated: isRated),
        );
      },
      separatorBuilder: (_, i) => Gap.medium(),
    );
  }

  Widget _buildAction({bool isRated = false}) {
    final IconData icon = isRated
        ? MvIcons.checkedOutlined
        : MvIcons.arrowForward;
    return Icon(icon, size: 22.sp, color: AppColors.primary);
  }
}
