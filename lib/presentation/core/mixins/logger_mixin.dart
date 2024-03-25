import 'package:flutter/foundation.dart';

mixin LoggerMixin {

  String isLogged = "";

  void log(String message) {
    if (kDebugMode) {
      print("[${DateTime.now()}] $message");
    }
  }

}