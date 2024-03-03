import 'dart:ui';
import 'package:flutter_clean_architecture/presentation/core/language/languages.dart';
import '../language/language_en.dart';
import '../language/language_es.dart';
import '../language/language_fr.dart';
import '../language/language_id.dart';
import '../language/language_ja.dart';
import '../language/language_ko.dart';
import '../language/language_zh.dart';

class LanguageServiceValues {

  static const String english = 'English';
  static const String indonesian = 'Indonesian';
  static const String korean = 'Korean';
  static const String japanese = 'Japanese';
  static const String chinese = 'Chinese';
  static const String french = 'French';
  static const String spanish = 'Spanish';

  static const List<String> localeString = [english, indonesian, korean, japanese, french, spanish, chinese];
  static const List<Locale> localeValue = [Locale('en', ''), Locale('id', ''), Locale('ko', ''), Locale('ja', ''), Locale('fr', ''), Locale('es', ''), Locale('zh', '')];
  static List<Languages> localeLanguage = [LanguageEn(), LanguageId(), LanguageKo(), LanguageJa(), LanguageFr(), LanguageEs(), LanguageZh()];

}