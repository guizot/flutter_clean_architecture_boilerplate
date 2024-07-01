import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/core/enums/navigation_enum.dart';
import '../constant/routes_values.dart';

class NavigationHandler {

  Future<Object?> navigate({
    required BuildContext context,
    required String route,
    NavigateEnum navigation = NavigateEnum.navigatePush,
    Object? arguments,
  }) {
    switch (navigation) {
      /// Push a new route onto the stack.
      case NavigateEnum.navigatePush:
        return Navigator.pushNamed(context, route, arguments: arguments);
      /// Replace the current route with a new one.
      case NavigateEnum.navigateReplace:
        return Navigator.pushReplacementNamed(context, route, arguments: arguments);
      /// Remove all previous routes and push the new one.
      case NavigateEnum.navigateRemove:
        return Navigator.pushNamedAndRemoveUntil(context, route, (Route<dynamic> route) => false, arguments: arguments);
      /// Pop the current route and push a new one.
      case NavigateEnum.popPush:
        return Navigator.popAndPushNamed(context, route, arguments: arguments);
    }
  }

  void pop({
    required BuildContext context,
    String route = RoutesValues.home,
    PopEnum navigation = PopEnum.popOnce,
  }) {
    switch (navigation) {
      /// Pop routes until the specified route is reached.
      /// required to pass --> MaterialPageRoute(settings: settings)
      case PopEnum.popUntil:
        return Navigator.popUntil(context, (Route<dynamic> r) {
          return r.settings.name == route || r.isFirst;
        });
      /// Pop the current route.
      case PopEnum.popOnce:
        return Navigator.pop(context);
    }
  }

}
