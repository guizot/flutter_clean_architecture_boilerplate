import 'package:flutter/foundation.dart';

mixin LoggerMixin {
  void log(String message) {
    if (kDebugMode) {
      print("[${DateTime.now()}] $message");
    }
  }
}