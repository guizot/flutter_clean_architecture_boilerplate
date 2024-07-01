import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/core/enums/navigation_enum.dart';

class NavigationService {

  void navigateTo({
    required BuildContext context,
    required String route,
    NavigationEnum navigation = NavigationEnum.pushed,
    bool replace = false,
    Object? arguments
  }) {
    switch(navigation) {
      case NavigationEnum.pushed:
        Navigator.pushNamed(context, route, arguments: arguments);
      case NavigationEnum.replace:
        Navigator.pushReplacementNamed(context, route, arguments: arguments);
      case NavigationEnum.remove:
        Navigator.pushNamedAndRemoveUntil(context, route, (Route<dynamic> route) => false, arguments: arguments);
    }
  }

}