import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/pages/home/home.dart';

class Routes {

  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeWrapperProvider());
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