import 'package:flutter/material.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get title;

  String get description;

  String get themeMode;

  String get themeColor;

  String get language;

}