import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';

class ClipboardHelper {
  const ClipboardHelper._();

  static final ClipboardHelper _instance = const ClipboardHelper._();

  static ClipboardHelper get instance => _instance;

  Future<void> copyToClipboard(
    String text, {
    required BuildContext context,
  }) async {
    try {
      Clipboard.setData(ClipboardData(text: text)).whenComplete(() {
        if (!context.mounted) return;
        context.flash(message: AppStrings.copiedToClipboard.tr());
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
