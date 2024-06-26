import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/data/data_source/shared/shared_preferences_data_source.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/core/constant/theme_service_values.dart';
import '../../../data/core/constant/shared_preferences_values.dart';

class ThemeService extends ChangeNotifier {

  final SharedPreferenceDataSource sharedPreferenceDataSource;
  ThemeService({required this.sharedPreferenceDataSource}) {
    _themeMode = ThemeServiceValues.system;
    _colorSeed = ThemeServiceValues.colorBlue;
    _fontFamily = ThemeServiceValues.fontNone;
    getPreferences();
  }

  late String _themeMode;
  String get themeMode => _themeMode;

  set themeMode(String value) {
    _themeMode = value;
    sharedPreferenceDataSource.setString(SharedPreferencesValues.currentTheme, value);
    notifyListeners();
  }

  late String _colorSeed;
  String get colorSeed => _colorSeed;

  set colorSeed(String value) {
    _colorSeed = value;
    sharedPreferenceDataSource.setString(SharedPreferencesValues.currentColor, value);
    notifyListeners();
  }

  late String _fontFamily;
  String get fontFamily => _fontFamily;

  set fontFamily(String value) {
    _fontFamily = value;
    sharedPreferenceDataSource.setString(SharedPreferencesValues.currentFont, value);
    notifyListeners();
  }

  getPreferences() async {
    _themeMode = await sharedPreferenceDataSource.getString(SharedPreferencesValues.currentTheme);
    if(_themeMode == "") {
      themeMode = ThemeServiceValues.system;
    }
    _colorSeed = await sharedPreferenceDataSource.getString(SharedPreferencesValues.currentColor);
    if(_colorSeed == "") {
      colorSeed = ThemeServiceValues.colorBlue;
    }
    _fontFamily = await sharedPreferenceDataSource.getString(SharedPreferencesValues.currentFont);
    if(_fontFamily == "") {
      fontFamily = ThemeServiceValues.fontNone;
    }
    notifyListeners();
  }

  ThemeMode get currentThemeMode {
    switch(themeMode) {
      case ThemeServiceValues.light:
        return ThemeMode.light;
      case ThemeServiceValues.dark:
        return ThemeMode.dark;
      case ThemeServiceValues.system:
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  ThemeData currentThemeData(String brightness) {
    Map<String, ThemeData> themeObject = {};
    for (int i = 0; i < ThemeServiceValues.colorString.length; i++) {
      themeObject[ThemeServiceValues.colorString[i]] = getThemeData(brightness, ThemeServiceValues.colorString[i]);
    }
    return themeObject[colorSeed]!;
  }

  ThemeData getThemeData(String brightness, String color) {

    Brightness brightnessTheme;
    switch(brightness) {
      case ThemeServiceValues.light:
        brightnessTheme = Brightness.light;
      case ThemeServiceValues.dark:
        brightnessTheme = Brightness.dark;
      default:
        brightnessTheme = Brightness.light;
    }

    Color colorTheme;
    Map<String, Color> colorObject = {};
    for (int i = 0; i < ThemeServiceValues.colorString.length; i++) {
      colorObject[ThemeServiceValues.colorString[i]] = ThemeServiceValues.colorValue[i];
    }
    colorTheme = colorObject[color]!;

    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: colorTheme,
      brightness: brightnessTheme,
      chipTheme: ChipThemeData(
        selectedColor: colorTheme.toMaterialColor().shade500
      ),
      fontFamily: fontFamily,
      appBarTheme: AppBarTheme(
        color: brightnessTheme == Brightness.dark
            ? ColorScheme.fromSeed(seedColor: colorTheme).primary
            : ColorScheme.fromSeed(seedColor: colorTheme).inversePrimary
      )
    );
  }

}
