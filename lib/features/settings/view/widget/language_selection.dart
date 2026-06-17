import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_assets.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/gap.dart';

class _Locales {
  final String name;
  final String path;
  final bool available;
  final Locale locale;
  final String? fontFamily;

  _Locales({
    required this.name,
    required this.locale,
    required this.path,
    this.fontFamily,
    required this.available,
  });
}

class LanguageSelection extends StatefulWidget {
  const LanguageSelection({super.key});

  @override
  State<LanguageSelection> createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {
  late final ValueNotifier<_Locales> _selectedLanguage;
  final List<_Locales> _languages = [
    _Locales(
      name: "English",
      path: AppAssets.gBFlag,
      available: true,
      locale: const Locale("en"),
    ),
    _Locales(
      name: "العربية",
      fontFamily: TextStyles.arFontFamily,
      path: AppAssets.sAFlag,
      available: true,
      locale: const Locale("ar"),
    ),
    _Locales(
      name: "Français",
      path: AppAssets.fRFlag,
      available: true,
      locale: const Locale("fr"),
    ),
    _Locales(
      name: "Español",
      path: AppAssets.eSFlag,
      available: true,
      locale: const Locale("es"),
    ),
    _Locales(
      name: "中文",
      path: AppAssets.cNFlag,
      available: true,
      locale: const Locale("zh"),
    ),

  ];
  @override
  void initState() {
    super.initState();
    _selectedLanguage = ValueNotifier(
      _languages.firstWhereOrNull(
            (e) => e.locale == userPreferencesCubit.state.locale,
      ) ??
          _languages.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<_Locales>(
      valueListenable: _selectedLanguage,
      builder: (context, value, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.language.tr(),
              style: TextStyles.labelLarge,
            ).appPaddingAll,
            const Gap(12),
            ..._languages.map(
                  (e) => _languageTile(
                e,
                selected: value == e,
              ),
            ),
            const Gap(16),
            AppButton(
              text: AppStrings.confirm.tr(),
              buttonSize: null,
              onPressed: () {
                final newLocale = value.locale;
                final isDifferent = newLocale != context.locale;
                if (isDifferent) {
                  userPreferencesCubit.changeLocale(newLocale, context);
                }
                context.pop();

              },
            ),
          ],
        ).appPaddingAll;
      },
    );
  }

  Widget _languageTile(_Locales locale, {bool selected = false}) {
    final selectedColor = AppColors.primary;

    return AppClick(
      onTap: () {
        if (locale.available) {
          _selectedLanguage.value = locale;
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Decorations.borderRadius8.r,
          ),
          border: Border.all(
            color: selected ? selectedColor : Colors.transparent,
          ),
          color: selected ? selectedColor.veryLight : Colors.transparent,
        ),
        child: Row(

          children: [
            SvgPicture.asset(
              locale.path,
              width: 36.w,
              height: 36.h,
            ),
              const Gap(12),
              Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    locale.name,
                    style: TextStyles.labelMedium.copyWith(
                      color: selected ? selectedColor : null,
                      fontFamily: locale.fontFamily,
                    ),
                  ),
                  if (!locale.available)
                    Text(
                      AppStrings.thisLanguageIsNotSupportedYet.tr(),
                      style: TextStyles.labelSmall.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                ],
              ),
            ),
            if (selected)
              Icon(
                MvIcons.checked,
                color: selectedColor,
                size: 24.h,
              ),
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