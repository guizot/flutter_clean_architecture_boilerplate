import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/injector.dart' as di;
import 'package:flutter_clean_architecture/presentation/core/routes.dart';
import 'package:flutter_clean_architecture/presentation/core/services/theme_service.dart';
import 'package:flutter_clean_architecture/presentation/core/utils/theme_service_values.dart';
import 'package:provider/provider.dart';
import 'injector.dart';

void main() async {

  /// ENSURE INITIALIZED
  WidgetsFlutterBinding.ensureInitialized();

  /// INIT DEPENDENCY INJECTION
  await di.init();

  /// RUN APP
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
            theme: notifier.currentThemeColor(ThemeServiceValues.light),
            darkTheme: notifier.currentThemeColor(ThemeServiceValues.dark),
            themeMode: notifier.currentThemeMode(),
          );
        },
      ),
    );
  }

}