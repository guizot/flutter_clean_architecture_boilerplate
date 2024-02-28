import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/data/datasources/shared_preferences_data_source.dart';
import '../../../data/utils/shared_preferences_values.dart';

class ThemeService extends ChangeNotifier {

  ThemeData _themeMode = ThemeData.light();
  ThemeData get themeMode => _themeMode;
  set themeMode(ThemeData themeData) {
    _themeMode = themeData;
    notifyListeners();
  }

  final SharedPreferenceDataSource sharedPreferenceDataSource;
  ThemeService({required this.sharedPreferenceDataSource});

  Future<void> init() async {
    final savedThemeMode = await sharedPreferenceDataSource.getString(SharedPreferencesValues.currentTheme);
    if (savedThemeMode == 'dark') {
      _themeMode = ThemeData.dark();
    } else if (savedThemeMode == 'light') {
      _themeMode = ThemeData.light();
    } else {
      _themeMode = ThemeData.light();
      sharedPreferenceDataSource.setString(SharedPreferencesValues.currentTheme, 'light');
    }
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeMode == ThemeData.light()) {
      _themeMode = ThemeData.dark();
      sharedPreferenceDataSource.setString(SharedPreferencesValues.currentTheme, 'dark');
      notifyListeners();
    } else {
      _themeMode = ThemeData.light();
      sharedPreferenceDataSource.setString(SharedPreferencesValues.currentTheme, 'light');
      notifyListeners();
    }
  }

}
