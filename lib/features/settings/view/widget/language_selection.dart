import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_assets.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';

class _Locales {
  final String name;
  final String path;
  final bool available;
  final Locale locale ;
  _Locales({required this.name, required this.locale, required this.path, required this.available});
}

class LanguageSelection extends StatefulWidget {
  const LanguageSelection({super.key});

  @override
  State<LanguageSelection> createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {
  late final ValueNotifier<_Locales> _selectedLanguage ;
  final List<_Locales> _languages = [
    _Locales(name: "English", path: AppAssets.gBFlag, available: true, locale: const Locale("en")),
    _Locales(name: "Arabic", path: AppAssets.sAFlag, available: false,locale:  const Locale("ar")),
  ];
@override
  void initState() {
    _selectedLanguage = ValueNotifier(_languages.firstWhere((e) => e.available));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _selectedLanguage,
      builder: (context, value, child) {
        return Column(
          spacing: 12.w,
          mainAxisSize: MainAxisSize.min,
          children:[
            Text("Language", style: TextStyles.labelLarge,).appPaddingAll,
            ... _languages
                .map(
                  (e) => _languageTile(e, selected: value == e),
            ),
             AppButton(text: "submit", buttonSize: null, onPressed: ()=>context.pop(_selectedLanguage.value.locale),),

          ]

        ).appPaddingAll;
      }
    );
  }

  Widget _languageTile(_Locales locale, {bool selected = false}) {
  final selectedColor = AppColors.primary ;
    return AppClick(
      onTap: () {
        if(locale.available) _selectedLanguage.value = locale;
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Decorations.borderRadius8.r),
            border: Border.all(color: selected ? selectedColor : Colors.transparent),
            color: selected ? selectedColor.veryLight : Colors.transparent,
          ),
        child: Row(
          spacing: 12.w,
          children: [
            SvgPicture.asset(locale.path, width: 36.w, height: 36.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(locale.name, style: TextStyles.labelMedium.copyWith(
                    color: selected ? selectedColor : null,
                  ),),
                  if(!locale.available)
                   Text("this language is not supported yet" , style: TextStyles.labelSmall.copyWith(
                     color: AppColors.error
                   ),)
                ],
              ),
            ),
            if(selected)
              Icon(MvIcons.checked, color: selectedColor, size: 24.h),
          ],
        ),
        ),
    );
  }

  @override
  void dispose() {
    _selectedLanguage.dispose();
    super.dispose();
  }
}
