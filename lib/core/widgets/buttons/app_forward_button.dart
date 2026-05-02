import 'package:multi_vendor/core/utils/mv_icons.dart';

import 'package:multi_vendor/core/widgets/buttons/app_icon_button.dart';

class AppForwardButton extends AppIconButton {
  const AppForwardButton({
    super.key,
    super.icon = MvIcons.arrowForward,
    super.onTap,
    super.tooltip = "Forward",
    super.iconColor,
    super.backGroundColor,
    super.enabled,
  });
}
