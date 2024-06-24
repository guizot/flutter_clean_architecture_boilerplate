import 'package:flutter/material.dart';

class DialogHandler {

  static void showAlertDialog({
    required BuildContext context,
    required Widget child,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return child;
      },
    );
  }

}