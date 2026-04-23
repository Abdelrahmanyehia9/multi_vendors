import 'package:flutter/material.dart';

import 'app_icon_button.dart';

class AppDeleteButton extends AppIconButton {
  const AppDeleteButton({
    super.key,
     super.icon = Icons.delete,
     super.onTap,
     super.tooltip = "Delete",
     super.iconColor,
     super.backGroundColor,
     super.enabled,
  });
}

