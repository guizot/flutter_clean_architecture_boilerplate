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

  Color toShade(double factor) {
    assert(factor >= -1.0 && factor <= 1.0, 'Factor must be between -1.0 and 1.0');
    if (factor == 0.0) return this;
    final hsl = HSLColor.fromColor(this);
    final hslModified = factor < 0
        ? hsl.withLightness((1.0 + factor) * hsl.lightness)
        : hsl.withLightness(hsl.lightness + (1.0 - hsl.lightness) * factor);
    return hslModified.toColor();
  }

}
