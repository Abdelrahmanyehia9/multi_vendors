import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/buttons/app_icon_button.dart';

class AppShareButton extends AppIconButton {
  const AppShareButton({
    super.key,
    super.icon = MvIcons.share,
    super.onTap,
    super.tooltip = AppStrings.share  ,
    super.iconColor,
    super.backGroundColor,
    super.enabled,
  });
}
