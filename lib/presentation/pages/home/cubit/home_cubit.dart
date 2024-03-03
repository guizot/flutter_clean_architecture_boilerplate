import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/data/datasources/shared_preferences_data_source.dart';
import 'package:flutter_clean_architecture/presentation/core/language/language_service.dart';
import '../../../core/services/theme_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeCubitState> {

  /// REGION: INIT CUBIT
  final SharedPreferenceDataSource sharedPreferenceDataSource;
  HomeCubit({required this.sharedPreferenceDataSource}) : super(HomeInitial());

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