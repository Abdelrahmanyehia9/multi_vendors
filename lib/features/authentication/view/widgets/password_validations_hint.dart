import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';

import '../../../../core/helper/app_validation.dart';
import '../../../../core/theme/text_styles.dart';

class _PasswordValidationHints extends StatelessWidget {
  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;
  const _PasswordValidationHints({
    required this.hasLowerCase,
    required this.hasUpperCase,
    required this.hasSpecialCharacters,
    required this.hasNumber,
    required this.hasMinLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 2.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recommended",
          style: TextStyles.labelSmall,
        ),
        buildValidationRow(
          "at least one lower case",
          hasLowerCase,context
        ),
        buildValidationRow(
          "at least one upper case",
          hasUpperCase,context
        ),
        buildValidationRow(
          "at least one special character" ,
          hasSpecialCharacters,context
        ),
        buildValidationRow("at least one number", hasNumber,context ),
        buildValidationRow(
          "at least 8 characters",
          hasMinLength,context
        ),
      ],
    ).paddingHr(4);
  }

  Widget buildValidationRow(String text, bool hasValidated, BuildContext context) {
    final disabledColor = context.colors.surfaceContainerLow ;
    return Row(
      spacing: 6.w,
      children: [
        CircleAvatar(
          radius: 3.5.r,
          backgroundColor:
          hasValidated ? AppColors.success : disabledColor,
        ),
        Text(
          text,
          style: TextStyles.captionMedium.copyWith(
            decoration: hasValidated ? TextDecoration.lineThrough : null,
            decorationColor: AppColors.success,
            decorationThickness: 1.sp,
            color:
            hasValidated
                ? AppColors.success
                : context.colors.surfaceContainer,
          ),
        ),
      ],
    );
  }
}
class PasswordValidationBuilder extends StatefulWidget {
  final TextEditingController controller ;
  final Widget? Function({bool hasLowerCase, bool hasUpperCase, bool hasSpecialCharacter, bool hasNumber, bool hasMinLength})? builder ;
  const PasswordValidationBuilder({super.key, this.builder ,required this.controller});

  @override
  State<PasswordValidationBuilder> createState() => _PasswordValidationBuilderState();
}
class _PasswordValidationBuilderState extends State<PasswordValidationBuilder> {
  bool hasLowerCase = false;
  bool hasUpperCase = false;
  bool hasSpecialCharacter = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  @override
  void initState() {
    setupPasswordControllerListener();
    super.initState();
  }

  void setupPasswordControllerListener() {
    widget.controller.addListener(() {
      setState(() {
        hasLowerCase = AppRegEX.hasLowerCase(widget.controller.text);
        hasUpperCase = AppRegEX.hasUpperCase(widget.controller.text);
        hasNumber = AppRegEX.hasNumber(widget.controller.text);
        hasSpecialCharacter = AppRegEX.hasSpecialCharacter(
          widget.controller.text,
        );
        hasMinLength = AppRegEX.hasMinLength(widget.controller.text);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return widget.builder?.call(hasLowerCase: hasLowerCase, hasUpperCase: hasUpperCase, hasSpecialCharacter: hasSpecialCharacter, hasNumber: hasNumber, hasMinLength: hasMinLength)??
    _PasswordValidationHints(hasLowerCase: hasLowerCase, hasUpperCase: hasUpperCase, hasSpecialCharacters: hasSpecialCharacter, hasNumber: hasNumber, hasMinLength: hasMinLength)
    ;
  }
}
