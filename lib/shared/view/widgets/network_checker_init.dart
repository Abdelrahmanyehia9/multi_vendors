import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/connection_cubit.dart';
import 'package:multi_vendor/core/cubit/connection_states.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';

class NetworkCheckerInit extends StatelessWidget {
  final Widget child;
  const NetworkCheckerInit({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    final double padding = MediaQuery.of(context).padding.top;
    return BlocBuilder<ConnectionCubit, ConnectionStates>(
      builder: (_, state) {
        final hasNoInternet = state is HaveNotConnection || state is HaveConnectionWithoutNetwork ;
        final color = state is HaveNotConnection ? AppColors.error : AppColors.warning;
        final icon = state is HaveNotConnection ? CupertinoIcons.wifi_slash : CupertinoIcons.info;
        final text = state is HaveNotConnection ? AppStrings.networkError : AppStrings.unstableNetwork;
        return Material(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (hasNoInternet)
                Container(
                  color: color,
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding:  EdgeInsets.only(top: padding, bottom: 12.h),
                  child: Row(
                    spacing: 8.w,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Icon(
                        icon,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: context.width*.6,
                        child: Text(
                          text.tr() ,
                          textAlign: TextAlign.center,
                          style: TextStyles.labelMedium
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              ,
              Expanded(
                child: child,
              ),
            ],
          ),
        );
      },
    ) ;
  }
}
