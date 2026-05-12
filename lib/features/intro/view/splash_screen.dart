import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/app_logo.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';

import 'package:multi_vendor/features/intro/logic/splash_logic.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _poweredByAnim;
  late Animation<Offset> _nexyraAnim;

  @override
  void initState() {
    super.initState();
    init();
  }


  Future<void> init() async{
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _poweredByAnim = Tween<Offset>(
      begin: const Offset(-1.8, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.9, curve: Curves.easeOut),
    ));

    _nexyraAnim = Tween<Offset>(
      begin: const Offset(1.8, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    ));

  await  Future.delayed(const Duration(milliseconds: 500), () {
      _controller.forward().whenComplete(() {
        SplashLogic.init(context);
      });
    });
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Column(
        children: [
          const Spacer(),
          const AppLogo(size: 80,),
          const Spacer(),
          ClipRect(
            child: Column(
              children: [
                SlideTransition(
                  position: _poweredByAnim,

                  child: Text(
                    AppStrings.poweredBy.tr(),
                    style: TextStyles.labelSmall
                        .copyWith(color: AppColors.primary),
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