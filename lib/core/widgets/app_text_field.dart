import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/text_styles.dart';
import 'gap.dart';
enum TextFieldBorderType { filled, outlined, underlined, none }

class AppTextField extends StatelessWidget {
  final TextFieldBorderType borderType;
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
    this.borderType = TextFieldBorderType.outlined,
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
    this.borderRadius = 10,
    this.borderWidth = 0.5,
    this.scrollController,
  });

  InputBorder _getBorder(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    switch (borderType) {
      case TextFieldBorderType.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        );
      case TextFieldBorderType.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor ?? theme.colorScheme.surfaceContainer,
            width: borderWidth,
          ),
        );
      case TextFieldBorderType.underlined:
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? theme.colorScheme.surfaceContainer,
            width: borderWidth,
          ),
        );
      case TextFieldBorderType.none:
        return InputBorder.none;
    }
  }
  InputBorder _getFocusedBorder(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    switch (borderType) {
      case TextFieldBorderType.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        );
      case TextFieldBorderType.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor ?? theme.colorScheme.surfaceContainerHighest,
            width: borderWidth,
          ),
        );
      case TextFieldBorderType.underlined:
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? theme.colorScheme.surfaceContainerHighest,
            width: borderWidth,
          ),
        );
      case TextFieldBorderType.none:
        return InputBorder.none;
    }
  }
  InputBorder _getErrorBorder() {
    switch (borderType) {
      case TextFieldBorderType.filled:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: AppColors.error, width: borderWidth),
        );
      case TextFieldBorderType.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: AppColors.error, width: borderWidth),
        );
      case TextFieldBorderType.underlined:
        return UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.error, width: borderWidth),
        );
      case TextFieldBorderType.none:
        return InputBorder.none;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (headerText != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(headerText!, style: headerStyle ?? TextStyles.labelSmall),
          Gap(gapUnderHeader ?? 4),
          _textField(context),
        ],
      );
    }
    return _textField(context);
  }

  Widget _textField(BuildContext context) {
    final ThemeData theme = Theme.of(context);
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
      decoration: InputDecoration(
        prefixIconColor: theme.colorScheme.surfaceContainer,
        contentPadding: padding,
        suffixIconColor: theme.colorScheme.surfaceContainer,
        filled: borderType == TextFieldBorderType.filled,
        fillColor:
        filledColor ??
            (borderType == TextFieldBorderType.filled
                ? theme.colorScheme.surfaceContainerLow
                : null),
        prefixIcon: prefix,
        suffixIcon: suffix,
        helperText: helperText,
        hintText: hintText,
        helperStyle: helperStyle,
        errorStyle: errorStyle,
        counterText: hideCounter ? '' : null,
        hintStyle:
        hintStyle ??
            TextStyles.bodyMedium.copyWith(
              color: theme.colorScheme.surfaceContainer,
            ),
        labelStyle:
        labelStyle ??
            TextStyles.bodyMedium.copyWith(
              color: theme.colorScheme.surfaceContainer,
            ),
        labelText: labelText,
        border: _getBorder(context),
        enabledBorder: _getBorder(context),
        disabledBorder: _getBorder(context),
        focusedBorder: _getFocusedBorder(context),
        errorBorder: _getErrorBorder(),
        focusedErrorBorder: _getErrorBorder(),
      ),
    );
  }
}