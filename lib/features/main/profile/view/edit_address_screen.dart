import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/helper/app_validation.dart';
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
        title: "address",
        actions: [AppDeleteButton(onTap: resetAddress)],
      ),
      body: BaseBlocConsumer(
        bloc: profileCubit,
        onSuccess: (s)=>context.pop(address),
        builder:(state)=> SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              spacing: 12.h,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.w,
                  children: [
                    Expanded(
                      child: _textField(
                        label: "Country",
                        controller: countryController,
                      ),
                    ),
                    Expanded(
                      child: _textField(
                        label: "City",
                        controller: cityController,
                      ),
                    ),
                  ],
                ),
                _textField(label: "Street", controller: streetController),
                Row(
                  spacing: 4.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _textField(
                        label: "building",
                        controller: buildingController,
                      ),
                    ),
                    Expanded(
                      child: _textField(
                        label: "apartment",
                        controller: apartmentController,
                      ),
                    ),
                    Expanded(
                      child: _textField(
                        label: "floor",
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
                        label: "Special Mark",
                        controller: specialMarkController,
                        isOptional: true,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: _textField(
                        label: "Postal Code",
                        controller: zipCodeController,
                        isOptional: true,
                        isNumeric: true,
                        maxLength: 10,
                      ),
                    ),
                  ],
                ),
                _textField(label: "Location name",isOptional: true, controller: locationNameController),
                Gap.tiny(),
                 AppButton(text: "Save",
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
      hintText: "Enter $label ${isOptional ? "(optional)" : ""}",
      controller: controller,
      customHeader: header,
      hintStyle: TextStyles.captionSmall,
      maxLength: maxLength,
      validator: isOptional ? null : (v) => AppValidation.validateRequired(v),
      keyboardType: isNumeric ? TextInputType.number : null,
      formatter: [if (isNumeric) FilteringTextInputFormatter.digitsOnly],
    );
  }
}
