import 'package:collection/collection.dart';
import 'package:intl_phone_field/countries.dart';
extension CountryExtension on String{
  Country get toCountry{
  final Country? country =   countries.firstWhereOrNull((element) => element.code == this);
  return country ?? const Country(
    name: "Egypt",
    nameTranslations: {
      "sk": "Egypt",
      "se": "Egypt",
      "pl": "Egipt",
      "no": "Egypt",
      "ja": "エジプト",
      "it": "Egitto",
      "zh": "埃及",
      "nl": "Egypt",
      "de": "Ägypt",
      "fr": "Égypte",
      "es": "Egipt",
      "en": "Egypt",
      "pt_BR": "Egito",
      "sr-Cyrl": "Египат",
      "sr-Latn": "Egipat",
      "zh_TW": "埃及",
      "tr": "Mısır",
      "ro": "Egipt",
      "ar": "مصر",
      "fa": "مصر",
      "yue": "埃及"
    },
    flag: "🇪🇬",
    code: "EG",
    dialCode: "20",
    minLength: 10,
    maxLength: 10,
  );
  }
}
