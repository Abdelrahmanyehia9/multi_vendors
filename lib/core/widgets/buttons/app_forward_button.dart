import 'package:flutter/material.dart';

import 'package:multi_vendor/core/widgets/buttons/app_icon_button.dart';

class AppForwardButton extends AppIconButton {
  const AppForwardButton({
    super.key,
    super.icon = Icons.arrow_forward,
    super.onTap,
    super.tooltip = "Forward",
    super.iconColor,
    super.backGroundColor,
    super.enabled,
  });
}
