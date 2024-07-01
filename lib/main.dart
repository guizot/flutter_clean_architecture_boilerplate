import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/injector.dart' as di;
import 'package:flutter_clean_architecture/presentation/core/routes/routes.dart';
import 'package:flutter_clean_architecture/presentation/core/services/deep_link_service.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_clean_architecture/presentation/core/services/theme_service.dart';
import 'package:flutter_clean_architecture/presentation/core/constant/theme_service_values.dart';
import 'package:provider/provider.dart';
import 'data/data_source/local/hive_data_source.dart';
import 'injector.dart';

void main() async {

  /// ENSURE INITIALIZED
  WidgetsFlutterBinding.ensureInitialized();

  /// INIT DEPENDENCY INJECTION
  await di.init();

  /// INIT HIVE LOCAL DATABASE
  await HiveDataSource.init();

  /// RUN APP
  runApp(const MainApp());

}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {

  final _navigatorKey = GlobalKey<NavigatorState>();
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      if (uri.pathSegments.contains('product')) {
        String? id = uri.queryParameters['id'];
        if (id != null) {
          _navigatorKey.currentState?.pushNamed(uri.path, arguments: id);
        }
      } else {
        _navigatorKey.currentState?.pushNamed(uri.path);
      }
    });
  }

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
            navigatorKey: _navigatorKey,
            onGenerateRoute: Routes.generate,
            theme: themeService.currentThemeData(ThemeServiceValues.light),
            darkTheme: themeService.currentThemeData(ThemeServiceValues.dark),
            themeMode: themeService.currentThemeMode,
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