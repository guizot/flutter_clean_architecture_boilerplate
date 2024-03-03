import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/pages/home/home.dart';
import 'package:flutter_clean_architecture/presentation/pages/setting/setting.dart';

import '../utils/routes_values.dart';

class Routes {

  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case RoutesValues.home:
        return MaterialPageRoute(builder: (_) => const HomeWrapperProvider());
      case RoutesValues.setting:
        return MaterialPageRoute(builder: (_) => const SettingWrapperProvider());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            appBar: AppBar(title: const Text("Error")),
            body: const Center(child: Text('Error page')),
          );
        });
    }
  }

}