import 'package:easy_localization/easy_localization.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';

class DateTimeStrings {
  const DateTimeStrings._();

  static final String justNow   = AppStrings.justNow.tr();
  static final String yesterday = AppStrings.yesterday.tr();
  static final String tomorrow  = AppStrings.tomorrow.tr();
  static final String unknown   = AppStrings.unknown.tr();
  static final String ago = AppStrings.ago.tr();
  static final String inPrefix = AppStrings.inPrefix.tr();
  static final String minuteSingular = AppStrings.minuteSingular.tr();
  static final String minutePlural   = AppStrings.minutePlural.tr();
  static final String hourSingular   = AppStrings.hourSingular.tr();
  static final String hourPlural     = AppStrings.hourPlural.tr();
  static final String daySingular    = AppStrings.daySingular.tr();
  static final String dayPlural      = AppStrings.dayPlural.tr();
  static final String weekSingular   = AppStrings.weekSingular.tr();
  static final String weekPlural     = AppStrings.weekPlural.tr();
  static final String monthSingular  = AppStrings.monthSingular.tr();
  static final String monthPlural    = AppStrings.monthPlural.tr();
  static final String yearSingular   = AppStrings.yearSingular.tr();
  static final String yearPlural     = AppStrings.yearPlural.tr();

  static final String am = AppStrings.am.tr();
  static final String pm = AppStrings.pm.tr();

  static final List<String> months = AppStrings.months.map((e) => e.tr()).toList() ;
}
