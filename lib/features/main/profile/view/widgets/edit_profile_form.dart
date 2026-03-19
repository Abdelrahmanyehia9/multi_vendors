import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../core/widgets/gap.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});
  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final ValueNotifier<bool>_isMaleNotifier = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.h,
      children: [
        _textField(label: "Full Name"),
        _textField(label: "Mobile Number"),
        _GenderSelector(_isMaleNotifier),
       _textField(label: "Birth Date", readOnly: true),
        _textField(label: "Address", maxLines: 2),
      ],
    );
  }

  Widget _textField({required String label, int? maxLines, bool readOnly = false})=>AppTextField(
    borderWidth: 1.2,
    maxLines: maxLines??1,
    readOnly: readOnly,
    hintText: "Enter $label",headerText: label,);
}
class _GenderSelector extends StatelessWidget {
  final ValueNotifier<bool> isMale;

  const _GenderSelector(this.isMale);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isMale,
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            child!,
            RadioGroup<bool>(
              groupValue: value,
              onChanged: (v) => isMale.value = v!,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children:  [
                  _ratioItem(value: true, title: "Men"),
                  Gap.medium(),
                  _ratioItem(value: false, title: "Women"),
                ],
              ),
            ),
          ],
        );
      },
      child: Text("Gender", style: TextStyles.labelSmall,),
    );
  }

  Widget _ratioItem({required bool value, required String title})=> Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Radio<bool>(value: value,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      Text(title, style: TextStyles.captionMedium,),
    ],
  );
}
