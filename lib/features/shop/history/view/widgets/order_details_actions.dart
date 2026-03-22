import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/utils/feature_flags.dart';
import '../../../../../core/widgets/app_button.dart';

class OrderDetailsActions extends StatelessWidget {
  const OrderDetailsActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.h,
      children: [
        // ignore: dead_code
        if(false)...[
          const AppButton(text: "Order Again",buttonSize: null,),
          if(FeatureFlags.enableRating)
            AppButton.outlined(text: "Rate order",onPressed: ()=>context.pushNamed(Routes.rateOrder),),
        ]
        else
       const AppButton(text: "Track Order",buttonSize: null,)

      ],
    );
  }
}