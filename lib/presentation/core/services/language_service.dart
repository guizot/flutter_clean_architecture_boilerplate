import 'package:flutter_clean_architecture/data/data_source/shared_preferences_data_source.dart';
import 'package:flutter_clean_architecture/presentation/core/constant/language_service_values.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../../data/utils/shared_preferences_values.dart';
import 'package:flutter/cupertino.dart';
import '../languages/language_delegation.dart';

class LanguageService extends ChangeNotifier {

  final SharedPreferenceDataSource sharedPreferenceDataSource;
  LanguageService({required this.sharedPreferenceDataSource}) {
    _language = LanguageServiceValues.english;
    getPreferences();
  }

  late String _language;
  String get language => _language;

  set language(String value) {
    _language = value;
    sharedPreferenceDataSource.setString(SharedPreferencesValues.currentLanguage, value);
    notifyListeners();
  }

  getPreferences() async {
    _language = await sharedPreferenceDataSource.getString(SharedPreferencesValues.currentLanguage);
    if(_language == "") {
      language = LanguageServiceValues.english;
    }
    notifyListeners();
  }

  Locale get currentLanguage {
    Map<String, Locale> localeObject = {};
    for (int i = 0; i < LanguageServiceValues.localeString.length; i++) {
      localeObject[LanguageServiceValues.localeString[i]] = LanguageServiceValues.localeValue[i];
    }
    return localeObject[language]!;
  }

  List<Locale> get supportedLocales => LanguageServiceValues.localeValue;

  List<LocalizationsDelegate> get localizationsDelegates => [
    const AppLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  LocaleResolutionCallback get localeResolutionCallback => (locale, supportedLocales) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale?.languageCode &&
          supportedLocale.countryCode == locale?.countryCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  };

}
