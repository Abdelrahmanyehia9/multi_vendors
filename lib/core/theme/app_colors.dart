import 'dart:ui';

class AppColors {
  const AppColors._();
  // ─── Primary ───────────────────────────────────────────
  static const Color primary100 = Color(0xffFFEBCC);
  static const Color primary200 = Color(0xffFFD199);
  static const Color primary300 = Color(0xffFFB266);
  static const Color primary400 = Color(0xffFF933F);
  static const Color primary500 = Color(0xffFF6000);
  static const Color primary600 = Color(0xffDB4500);
  static const Color primary700 = Color(0xffB72E00);
  static const Color primary800 = Color(0xff931C00);
  static const Color primary900 = Color(0xff7A1000);
  static const Color primary    = primary500;
  // ─── Secondary ─────────────────────────────────────────
  static const Color secondary100 = Color(0xffFDFEFE);
  static const Color secondary200 = Color(0xffFCFDFE);
  static const Color secondary300 = Color(0xffF9FAFC);
  static const Color secondary400 = Color(0xffF5F7F9);
  static const Color secondary500 = Color(0xffF1F3F6);
  static const Color secondary600 = Color(0xffB0BCD3);
  static const Color secondary700 = Color(0xff798BB1);
  static const Color secondary800 = Color(0xff4C5F8E);
  static const Color secondary900 = Color(0xff2E3F76);
  static const Color secondary     = primary;
  static const Color secondaryDark = secondary900;
// ─── Grey ──────────────────────────────────────────────
  static const Color white    = Color(0xffFFFFFF);
  static const Color grey50   = Color(0xffFAFAFA);
  static const Color grey100  = Color(0xffF5F5F5);
  static const Color grey200  = Color(0xffE6E6E6);
  static const Color grey300  = Color(0xffB3B3B3);
  static const Color grey400  = Color(0xff999999);
  static const Color grey500  = Color(0xff666666);
  static const Color grey600  = Color(0xff4D4D4D);
  static const Color grey700  = Color(0xff333333);
  static const Color grey800  = Color(0xff1A1A1A);
  static const Color grey900  = Color(0xff0D0D0D);
  static const Color grey1000 = Color(0xff050505);
  static const Color black    = Color(0xff000000);
  static const Color grey     = grey500;
  // ─── Success ───────────────────────────────────────────
  static const Color success100 = Color(0xffCEFDD3);
  static const Color success200 = Color(0xff9DFBB1);
  static const Color success300 = Color(0xff6BF496);
  static const Color success400 = Color(0xff46E989);
  static const Color success500 = Color(0xff0FDB78);
  static const Color success600 = Color(0xff0ABC77);
  static const Color success700 = Color(0xff079D72);
  static const Color success800 = Color(0xff047F68);
  static const Color success900 = Color(0xff026960);
  static const Color success    = success500;

  // ─── Info ──────────────────────────────────────────────
  static const Color info100 = Color(0xffCBFEF7);
  static const Color info200 = Color(0xff98FEF7);
  static const Color info300 = Color(0xff65FBFD);
  static const Color info400 = Color(0xff3EEAFB);
  static const Color info500 = Color(0xff00D0F9);
  static const Color info600 = Color(0xff00A2D6);
  static const Color info700 = Color(0xff007AB3);
  static const Color info800 = Color(0xff005790);
  static const Color info900 = Color(0xff003F77);
  static const Color info    = info500;
  // ─── Warning ───────────────────────────────────────────
  static const Color warning100 = Color(0xffFFFBEB);
  static const Color warning200 = Color(0xffFEF3C7);
  static const Color warning300 = Color(0xffFDE68A);
  static const Color warning400 = Color(0xffFBBF24);
  static const Color warning500 = Color(0xffF59E0B);
  static const Color warning600 = Color(0xffD97706);
  static const Color warning700 = Color(0xffB45309);
  static const Color warning800 = Color(0xff92400E);
  static const Color warning900 = Color(0xff78350F);
  static const Color warning    = warning500;
  static const Color gold    = warning300;
  // ─── Error ─────────────────────────────────────────────
  static const Color error100 = Color(0xffFEDDCB);
  static const Color error200 = Color(0xffFEB398);
  static const Color error300 = Color(0xffFE8065);
  static const Color error400 = Color(0xffFE503F);
  static const Color error500 = Color(0xffFE0000);
  static const Color error600 = Color(0xffDA0012);
  static const Color error700 = Color(0xffB6001F);
  static const Color error800 = Color(0xff930026);
  static const Color error900 = Color(0xff79002A);
  static const Color error    = error500;

  // ─── Main Colors ───────────────────────────
  static const List<Color> mainColors = [
    primary, secondaryDark, info, warning, error, success, grey,
  ];
  static const List<Color> mainDarkColors = [
    primary700, secondaryDark, info700, warning700, error700, success700, grey700,
  ];


  // extra
static const Color iceColor = Color(0xFF89E9FF) ;

}