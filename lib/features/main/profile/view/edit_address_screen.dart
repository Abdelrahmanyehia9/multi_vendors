import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/helper/app_validation.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/app_text_field.dart';
import 'package:multi_vendor/core/widgets/buttons/app_delete_button.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';

import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/features/main/profile/view/mixin/edit_address_mixin.dart';

class EditAddressScreen extends StatefulWidget {

  const EditAddressScreen({super.key});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen>
    with EditAddressMixin {

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: AppStrings.address.tr(),
        actions: [AppDeleteButton(onTap: resetAddress)],
      ),
      body: BaseBlocConsumer(
        bloc: addressCubit,
        onSuccess: (s)=>context.pop(address),
        builder:(state)=> SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              spacing: 12.h,
              children: [
                CircleAvatar(
                    backgroundColor: AppColors.primary,
                    radius: 60.r,
                    child: Icon(MvIcons.locationCity, color: AppColors.white, size: 80.sp,)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.w,
                  children: [
                    Expanded(
                      child: _textField(
                        label: AppStrings.country.tr(),
                        controller: countryController,
                      ),
                    ),
                    Expanded(
                      child: _textField(
                        label: AppStrings.city.tr(),
                        controller: cityController,
                      ),
                    ),
                  ],
                ),
                _textField(label: AppStrings.street.tr(), controller: streetController),
                Row(
                  spacing: 4.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _textField(
                        label: AppStrings.building.tr(),
                        controller: buildingController,
                      ),
                    ),
                    Expanded(
                      child: _textField(
                        label: AppStrings.apartment.tr(),
                        controller: apartmentController,
                      ),
                    ),
                    Expanded(
                      child: _textField(
                        label: AppStrings.floor.tr(),
                        isNumeric: true,
                        isOptional: true,
                        controller: floorController,
                        maxLength: 2,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.w,
                  children: [
                    Expanded(
                      flex: 3,
                      child: _textField(
                        label: AppStrings.specialMark.tr(),
                        controller: specialMarkController,
                        isOptional: true,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: _textField(
                        label: AppStrings.postalCode.tr(),
                        controller: zipCodeController,
                        isOptional: true,
                        isNumeric: true,
                        maxLength: 10,
                      ),
                    ),
                  ],
                ),
                _textField(label: AppStrings.locationName.tr() ,isOptional: true, controller: locationNameController),
                Gap.tiny(),
                 AppButton(text: AppStrings.save.tr(),
                     isLoading: state.isLoading,
                     buttonSize: null, onPressed: onSave),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textField({
    required String label,
    int? maxLines,
    TextEditingController? controller,
    int? maxLength,
    bool isNumeric = false,
    bool isOptional = false,
  }) {
    Widget header = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: TextStyles.labelSmall),
        if (!isOptional)
          Text(
            "*",
            style: TextStyles.labelSmall.copyWith(color: AppColors.error),
          ),
      ],
    );
    return AppTextField(
      borderWidth: 1.2,
      maxLines: maxLines ?? 1,
      borderType: AppBorderType.filled,
      autoValidateMode: AutovalidateMode.disabled,
      hintText: "${AppStrings.enter.tr()} $label ${isOptional ? AppStrings.optional.tr() : ""}",
      controller: controller,
      customHeader: header,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      maxLength: maxLength,
      validator: isOptional ? null : (v) => AppValidation.validateRequired(v),
      keyboardType: isNumeric ? TextInputType.number : null,
      formatter: [if (isNumeric) FilteringTextInputFormatter.digitsOnly],
    );
  }
}
