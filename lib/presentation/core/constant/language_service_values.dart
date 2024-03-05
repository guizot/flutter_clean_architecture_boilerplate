import 'dart:ui';
import 'package:flutter_clean_architecture/presentation/core/languages/languages.dart';
import '../languages/language_en.dart';
import '../languages/language_es.dart';
import '../languages/language_fr.dart';
import '../languages/language_id.dart';
import '../languages/language_ja.dart';
import '../languages/language_ko.dart';
import '../languages/language_zh.dart';

class LanguageServiceValues {

  /// LANGUAGE STRING CONSTANTS:
  static const String english = 'English';
  static const String indonesian = 'Indonesian';
  static const String korean = 'Korean';
  static const String japanese = 'Japanese';
  static const String chinese = 'Chinese';
  static const String french = 'French';
  static const String spanish = 'Spanish';

  /// TO ADD NEW LANGUAGE:
  /// PUT NEW STRING, LOCALE & LANGUAGE OBJECT TO THESE 3 ARRAY CONSTANTS
  /// THEN REBUILD AND LANGUAGE IS AUTOMATICALLY ADDED
  static const List<String> localeString = [
    english,
    indonesian,
    korean,
    japanese,
    french,
    spanish,
    chinese
  ];
  static const List<Locale> localeValue = [
    Locale('en', ''),
    Locale('id', ''),
    Locale('ko', ''),
    Locale('ja', ''),
    Locale('fr', ''),
    Locale('es', ''),
    Locale('zh', '')
  ];
  static List<Languages> localeLanguage = [
    LanguageEn(),
    LanguageId(),
    LanguageKo(),
    LanguageJa(),
    LanguageFr(),
    LanguageEs(),
    LanguageZh()
  ];

}