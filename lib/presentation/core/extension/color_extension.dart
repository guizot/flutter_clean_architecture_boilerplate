import 'package:flutter/material.dart';

extension ColorExtension on Color {

  /// Convert Color to Material Color
  MaterialColor toMaterialColor() {
    Map<int, Color> colorShades = {
      50: withOpacity(0.1),
      100: withOpacity(0.2),
      200: withOpacity(0.3),
      300: withOpacity(0.4),
      400: withOpacity(0.5),
      500: withOpacity(0.6),
      600: withOpacity(0.7),
      700: withOpacity(0.8),
      800: withOpacity(0.9),
      900: withOpacity(1.0),
    };
    return MaterialColor(value, colorShades);
  }

}
