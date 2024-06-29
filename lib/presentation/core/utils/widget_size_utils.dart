import 'package:flutter/material.dart';

class WidgetSizeUtils {
  static double getHeight(GlobalKey key) {
    final RenderBox renderBox = key.currentContext?.findRenderObject() as RenderBox;
    return renderBox.size.height;
  }

  static double getWidth(GlobalKey key) {
    final RenderBox renderBox = key.currentContext?.findRenderObject() as RenderBox;
    return renderBox.size.width;
  }
}