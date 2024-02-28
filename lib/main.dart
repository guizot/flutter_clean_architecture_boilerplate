import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/injector.dart' as di;
import 'package:flutter_clean_architecture/presentation/core/routes.dart';
import 'package:flutter_clean_architecture/presentation/core/services/theme_service.dart';
import 'package:provider/provider.dart';
import 'injector.dart';

void main() async {

  /// ENSURE INITIALIZED
  WidgetsFlutterBinding.ensureInitialized();

  /// INIT DEPENDENCY INJECTION
  await di.init();

  /// INIT THEME SERVICE
  final themeService = sl<ThemeService>();
  await themeService.init();

  runApp(const MainApp());

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => sl<ThemeService>(),
        )
      ],
      child: Consumer<ThemeService> (
        builder: (context, ThemeService notifier, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Routes.generate,
            // theme: ThemeData.light(),
            // darkTheme: ThemeData.dark(),
            themeMode: notifier.themeMode
          );
        },
      ),
    );
  }}