import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/data/datasources/shared_preferences_data_source.dart';
import 'package:flutter_clean_architecture/presentation/pages/setting/cubit/setting_state.dart';

import '../../../core/language/language_service.dart';
import '../../../core/services/theme_service.dart';

class SettingCubit extends Cubit<SettingCubitState> {

  /// REGION: INIT CUBIT
  final SharedPreferenceDataSource sharedPreferenceDataSource;
  SettingCubit({required this.sharedPreferenceDataSource}) : super(SettingInitial());

  /// TOGGLE THEME
  void toggleTheme(ThemeService notifier, String theme) {
    notifier.themeMode = theme;
  }

  /// TOGGLE COLOR
  void toggleColor(ThemeService notifier, String color) {
    notifier.colorSeed = color;
  }

  /// TOGGLE LANGUAGE
  void toggleLanguage(LanguageService notifier, String language) {
    notifier.language = language;
  }

}