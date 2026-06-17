library;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/app_logo.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/intro/logic/splash_logic.dart';

part 'mixin/splash_animation_mixin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin, SplashAnimationMixin {
  @override
  void initState() {
    initAnimation(
      vsync: this,
      onFinished: () async=>SplashLogic.init(context)
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Column(
        children: [
          const Spacer(),
          const AppLogo(size: 80),
          const Spacer(),
          ClipRect(
            child: Column(
              children: [
                SlideTransition(
                  position: _poweredByAnim,
                  child: Text(
                    AppStrings.poweredBy.tr(),
                    style: TextStyles.labelSmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
                SlideTransition(
                  position: _nexyraAnim,

                  child: Text(
                    AppStrings.nexyraTech.tr(),
                    style: TextStyles.labelMedium.copyWith(),
                  ),
                ),
              ],
            ),
          ),
          Gap.medium(),
        ],
      ),
    );
  }
}
