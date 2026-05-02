
import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/date_time.dart';

import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/app_text_field.dart';
import 'package:multi_vendor/core/widgets/gap.dart';

class BirthDateField extends StatefulWidget {
  final DateTime? initialDate ;
  final ValueChanged<DateTime> onSelected ;
  const BirthDateField({super.key, this.initialDate, required this.onSelected});

  @override
  State<BirthDateField> createState() => _BirthDateFieldState();
}

class _BirthDateFieldState extends State<BirthDateField> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    _controller.text = widget.initialDate?.formattedDate ?? '';
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AppTextField(
      borderWidth: 1.2,
      readOnly: true,
      controller: _controller,
      suffix:  Icon(MvIcons.calender),
      onTap: ()  async{
        final DateTime now = DateTime.now();
        DateTime? date = await  showDatePicker(
          context: context,
          initialDate:widget.initialDate ??  DateTime(now.year - 20, now.month, now.day),
          firstDate: DateTime(now.year - 100, now.month, now.day),
          lastDate: DateTime(now.year - 12, now.month, now.day),
        );
        if(date != null){
          widget.onSelected.call(date);
          _controller.text = date.formattedDate;
        }
      },
      borderType: AppBorderType.filled,
      hintText: "Enter Birth Date",
      headerText: "Birthdate",
    );
  }


}
class GenderSelector extends StatelessWidget {
  final ValueNotifier<bool> isMale;
  const GenderSelector(this.isMale, {super.key});

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
                children: [
                  _ratioItem(value: true, title: "Men"),
                  Gap.medium(),
                  _ratioItem(value: false, title: "Women"),
                ],
              ),
            ),
          ],
        );
      },
      child: Text("Gender", style: TextStyles.labelSmall),
    );
  }

  Widget _ratioItem({required bool value, required String title}) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Radio<bool>(
        value: value,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      Text(title, style: TextStyles.captionMedium),
    ],
  );
}
