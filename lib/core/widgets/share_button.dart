import 'package:flutter/material.dart';
import 'package:multi_vendor/core/widgets/app_button.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppIconButton(icon: Icons.share);
  }
}
