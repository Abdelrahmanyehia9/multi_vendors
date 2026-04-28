import 'package:flutter/material.dart';
import 'package:multi_vendor/core/utils/testing.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';

import 'package:multi_vendor/features/intro/logic/splash_logic.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SplashLogic.init(context);

  }
  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
      body: Center(
        child: AppCachedNetworkImage(Testing.logo,
        width: 160,
        height: 160,
        ),
      ),
    );
  }
}
