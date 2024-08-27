import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/injector.dart' as di;
import 'package:flutter_clean_architecture/presentation/core/routes/routes.dart';
import 'package:flutter_clean_architecture/presentation/core/services/deep_link_service.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_clean_architecture/presentation/core/services/theme_service.dart';
import 'package:flutter_clean_architecture/presentation/core/constant/theme_service_values.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'data/data_source/local/hive_data_source.dart';
import 'injector.dart';

void main() async {

  /// ENSURE INITIALIZED
  WidgetsFlutterBinding.ensureInitialized();

  /// INIT HIVE LOCAL DATABASE
  await initHiveForFlutter();
  await HiveDataSource.init();

  /// INIT DEPENDENCY INJECTION
  await di.init();

  /// INIT FIREBASE
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// RUN APP
  runApp(const MainApp());

}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    DeepLinkService(navigatorKey: navigatorKey);
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
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
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