import 'package:flutter/material.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/testing.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: AppCachedNetworkImage(Testing.logo, width: 120, height: 120),
        ),
        Text(
          "Welcome Back",
          textAlign: TextAlign.center,
          style: TextStyles.headline3,
        ),
        Text(
          "Please fill form below to Login",
          textAlign: TextAlign.center,
          style: TextStyles.captionLarge,
        ),
      ],
    );
  }
}
