import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/injector.dart' as di;
import 'package:flutter_clean_architecture/presentation/core/routes/routes.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
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
        ),
        ChangeNotifierProvider(
          create: (context) => sl<LanguageService>(),
        )
      ],
      child: Consumer2<ThemeService, LanguageService> (
        builder: (context, ThemeService themeService, LanguageService languageService, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Routes.generate,
            theme: themeService.currentThemeColor(ThemeServiceValues.light),
            darkTheme: themeService.currentThemeColor(ThemeServiceValues.dark),
            themeMode: themeService.currentThemeMode(),
            locale: languageService.currentLanguage,
            supportedLocales: languageService.supportedLocales,
            localizationsDelegates: languageService.localizationsDelegates,
            localeResolutionCallback: languageService.localeResolutionCallback,
          );
        },
      ),
    );
  }

}