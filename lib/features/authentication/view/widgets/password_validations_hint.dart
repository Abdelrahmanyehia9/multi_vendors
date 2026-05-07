import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/helper/app_validation.dart';

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
          AppStrings.recommended.tr(),
          style: TextStyles.labelSmall,
        ),
        buildValidationRow(
          AppStrings.atLeastOneLowerCase.tr(),
          hasLowerCase,context
        ),
        buildValidationRow(
          AppStrings.atLeastOneUpperCase.tr(),
          hasUpperCase,context
        ),
        buildValidationRow(
         AppStrings.atLeastOneSpecialCharacter.tr() ,
          hasSpecialCharacters,context
        ),
        buildValidationRow(AppStrings.atLeastOneNumber.tr(), hasNumber,context ),
        buildValidationRow(
          AppStrings.atLeast8Length.tr(),
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
