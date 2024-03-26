import 'package:flutter/material.dart';

class ThemeServiceValues {

  /// MODE STRING CONSTANTS:
  static const String light = 'Light';
  static const String dark = 'Dark';
  static const String system = 'System';

  static const List<String> themeString = [
    light,
    dark,
    system
  ];

  /// COLOR STRING CONSTANTS:
  static const String colorRed = 'Red';
  static const String colorGreen = 'Green';
  static const String colorBlue = 'Blue';
  static const String colorOrange = 'Orange';
  static const String colorPurple = 'Purple';
  static const String colorYellow = 'Yellow';

  /// TO ADD NEW COLOR:
  /// PUT NEW STRING & COLOR TO THESE 2 ARRAY CONSTANTS
  /// THEN REBUILD AND COLOR IS AUTOMATICALLY ADDED
  static const List<String> colorString = [
    colorRed,
    colorGreen,
    colorBlue,
    colorOrange,
    colorPurple,
    colorYellow
  ];
  static const List<Color> colorValue = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.yellow
  ];

  /// FONT STRING CONSTANTS:
  static const String fontNone = 'None';
  static const String fontPoppins = 'Poppins';
  static const String fontCormorantGaramond = 'Cormorant Garamond';
  static const String fontOutfit = 'Outfit';
  static const String fontRaleway = 'Raleway';

  /// TO ADD NEW FONT:
  static const List<String> fontString = [
    fontNone,
    fontPoppins,
    fontCormorantGaramond,
    fontOutfit,
    fontRaleway
  ];

}