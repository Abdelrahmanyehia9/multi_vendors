import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/decorations.dart';
import 'app_cached_network_image.dart';

class AppDropDown extends StatelessWidget {
  final int? value;
  final List<DropDownItem> items;
  final ValueChanged<int?> onChanged;
  final String? hint;
  final bool enabled;

  final bool showText;
  final bool showImage;

  const AppDropDown._({
    required this.items,
    required this.onChanged,
    this.value,
    this.hint,
    this.enabled = true,
    this.showText = true,
    this.showImage = false,
  });

  // ===== FACTORIES =====

  factory AppDropDown.text({
    required List<String> items,
    required ValueChanged<int?> onChanged,
    int? value,
    String? hint,
    bool enabled = true,
  }) {
    return AppDropDown._(
      items: items.map((e) => DropDownItem.text(e)).toList(),
      onChanged: onChanged,
      value: value,
      hint: hint,
      enabled: enabled,
    );
  }

  factory AppDropDown.image({
    required List<String> images,
    required ValueChanged<int?> onChanged,
    int? value,
    String? hint,
    bool enabled = true,
  }) {
    return AppDropDown._(
      items: images.map((e) => DropDownItem.image(e)).toList(),
      onChanged: onChanged,
      value: value,
      hint: hint,
      enabled: enabled,
      showText: false,
      showImage: true,
    );
  }

  factory AppDropDown.textAndImage({
    required List<DropDownItem> items,
    required ValueChanged<int?> onChanged,
    int? value,
    String? hint,
    bool enabled = true,
  }) {
    return AppDropDown._(
      items: items,
      onChanged: onChanged,
      value: value,
      hint: hint,
      enabled: enabled,
      showImage: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    int? initialValue;

    if (value != null && value! < items.length) {
      initialValue = value;
    } else if (items.isNotEmpty) {
      initialValue = 0;
    }

    return DropdownButtonFormField<int>(
      initialValue: initialValue,
      padding: EdgeInsets.symmetric(horizontal: 16.w,),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Decorations.borderRadius8.r),
              borderSide: const BorderSide(color: AppColors.grey200)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Decorations.borderRadius16.r),
              borderSide: const BorderSide(color: AppColors.grey200)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Decorations.borderRadius16.r),
              borderSide: const BorderSide(color: AppColors.grey)
          )
      ),
      items: List.generate(
        items.length,
            (index) => DropdownMenuItem<int>(
          value: index,
          child: Row(
            children: [
              if (showImage && items[index].image != null)
                AppCachedNetworkImage(
                  items[index].image!,
                  width: 36,
                  height: 36,
                ),

              if (showImage && showText) 8.horizontalSpace,

              if (showText && items[index].text != null)
                Text(items[index].text!),
            ],
          ),
        ),
      ),
      onChanged: enabled ? onChanged : null,
    );
  }

}

class DropDownItem {
  final String? text;
  final String? image;

  const DropDownItem.text(this.text) : image = null;
  const DropDownItem.image(this.image) : text = null;
  const DropDownItem.textAndImage(this.text, this.image);
}