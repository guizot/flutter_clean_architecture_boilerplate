import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/data/datasources/shared_preferences_data_source.dart';
import '../../../data/utils/shared_preferences_values.dart';

class ThemeService extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  final SharedPreferenceDataSource sharedPreferenceDataSource;
  ThemeService({required this.sharedPreferenceDataSource});

  Future<void> init() async {
    final savedThemeMode = await sharedPreferenceDataSource.getString(SharedPreferencesValues.currentTheme);
    if (savedThemeMode == 'dark') {
      _themeMode = ThemeMode.dark;
    } else if (savedThemeMode == 'light') {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.light;
      sharedPreferenceDataSource.setString(SharedPreferencesValues.currentTheme, 'light');
    }
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
      sharedPreferenceDataSource.setString(SharedPreferencesValues.currentTheme, 'dark');
    } else {
      _themeMode = ThemeMode.light;
      sharedPreferenceDataSource.setString(SharedPreferencesValues.currentTheme, 'light');
    }
    notifyListeners();
  }

}
