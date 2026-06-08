import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/gap.dart';

enum AppBorderType { filled, outlined, underlined, none }


class AppTextField extends StatelessWidget {
  final AppBorderType borderType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextStyle? style;
  final bool autofocus;
  final TextAlign? textAlign;
  final bool readOnly;
  final bool? showCursor;
  final bool enabled;
  final EdgeInsets? padding;
  final AutovalidateMode? autoValidateMode;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final String? headerText;
  final SmartDashesType? smartDashesType;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final int maxLines;
  final int? minLines;
  final bool expands;
  final TextStyle? headerStyle;
  final double? gapUnderHeader;
  final int? maxLength;
  final bool hideCounter;
  final String? helperText;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? helperStyle;
  final TextStyle? errorStyle;
  final Widget? suffix;
  final List<TextInputFormatter>? formatter;
  final Widget? prefix;
  final Color? filledColor;
  final Color? borderColor;
  final double borderRadius;
  final double borderWidth;
  final Widget? customHeader ;
  final void Function(String?)? onChange;
  final void Function()? onTap;
  final void Function(String?)? onSubmit;
  final void Function()? onEditingComplete;
  final ScrollController? scrollController;

  const AppTextField({
    super.key,
    this.autofocus = false,
    this.onChange,
    this.onTap,
    this.onSubmit,
    this.onEditingComplete,
    this.textAlign,
    this.headerText,
    this.customHeader,
    this.borderType = AppBorderType.outlined,
    this.readOnly = false,
    this.padding,
    this.smartDashesType,
    this.filledColor,
    this.helperText,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.hintText,
    this.labelText,
    this.enabled = true,
    this.hintStyle,
    this.gapUnderHeader,
    this.headerStyle,
    this.labelStyle,
    this.helperStyle,
    this.errorStyle,
    this.formatter,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.showCursor,
    this.obscuringCharacter = '*',
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.hideCounter = false,
    this.style,
    this.validator,
    this.controller,
    this.focusNode,
    this.initialValue,
    this.suffix,
    this.prefix,
    this.autocorrect = true,
    this.borderColor,
    this.borderRadius = Decorations.borderRadius8,
    this.borderWidth = 0.5,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    if (headerText != null || customHeader != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           customHeader ??  Text(headerText!, style: headerStyle ?? TextStyles.labelSmall),
          Gap(gapUnderHeader ?? 4),
          _textField(context),
        ],
      );
    }
    return _textField(context);
  }

  Widget _textField(BuildContext context) {
    final AppInputDecoration decorations = AppInputDecoration.instance.copyWith(
      borderType: borderType,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      borderColor: borderColor,
      helperStyle: helperStyle,
      hintStyle: hintStyle??TextStyles.bodyMedium.copyWith(
        color: context.colors.surfaceContainerLow
      ),
      labelStyle: labelStyle,
      errorStyle: errorStyle,
      padding: padding,
      filledColor: filledColor,
      hintText: hintText,
      labelText: labelText,
      helperText: helperText,
      suffix: suffix,
      prefix: prefix,
    );
    return TextFormField(
      obscureText: obscureText,
      enabled: enabled,
      onChanged: onChange,
      onTap: onTap,
      obscuringCharacter: obscuringCharacter,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      inputFormatters: formatter,
      controller: controller,
      focusNode: focusNode,
      textAlign: textAlign ?? TextAlign.start,
      onFieldSubmitted: onSubmit,
      onEditingComplete: onEditingComplete,
      initialValue: initialValue,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      validator: validator,
      autofocus: autofocus,
      readOnly: readOnly,
      showCursor: showCursor,
      autocorrect: autocorrect,
      smartDashesType: smartDashesType,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      maxLength: maxLength,
      scrollController: scrollController,
      style: style ?? TextStyles.bodyMedium,
      cursorColor: AppColors.primary,
      autovalidateMode: autoValidateMode,
      decoration: decorations.inputDecoration(context),
    );
  }
}

