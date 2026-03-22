import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/cards/checkout_card.dart';
import '../../../../../core/widgets/gap.dart';

class ListProductsToRateList extends StatelessWidget {
  final bool shrinkWrap;
  const ListProductsToRateList({super.key, this.shrinkWrap =true});

  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
      itemCount: 20,
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      itemBuilder: (_,i) {
        final bool isRated = i == 0 ;
        return CheckoutProductCard(
          onTap: isRated ? null : ()=>context.pushNamed(Routes.rateProduct),
          customAction: _buildAction(isRated: isRated)
      );
      },
      separatorBuilder: (_,i)=>Gap.medium(),
    );
  }

  Widget _buildAction({bool isRated = false}){
    final IconData icon = isRated ? Icons.check_circle : Icons.arrow_forward;
    return Icon(icon, size: 22.sp, color: AppColors.primary,) ;
  }

}
