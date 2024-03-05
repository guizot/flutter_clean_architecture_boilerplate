import 'package:flutter/cupertino.dart';
import '../constant/language_service_values.dart';
import 'languages.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {

  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    List<String> codes = [];
    for (int i = 0; i < LanguageServiceValues.localeValue.length; i++) {
      codes.add(LanguageServiceValues.localeValue[i].languageCode);
    }
    return codes.contains(locale.languageCode);
  }

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    Map<String, Languages> languageObject = {};
    for (int i = 0; i < LanguageServiceValues.localeValue.length; i++) {
      languageObject[LanguageServiceValues.localeValue[i].languageCode] = LanguageServiceValues.localeLanguage[i];
    }
    return languageObject[locale.languageCode]!;
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}