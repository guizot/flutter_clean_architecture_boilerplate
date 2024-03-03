import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/language/language_service.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../core/utils/language_service_values.dart';
import '../../core/utils/theme_service_values.dart';
import 'cubit/setting_cubit.dart';
import '../../../injector.dart';

class SettingWrapperProvider extends StatelessWidget {
  const SettingWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SettingCubit>(),
      child: const SettingPage(title: "Setting"),
    );
  }
}

class SettingPage extends StatefulWidget {
  const SettingPage({super.key, required this.title});
  final String title;

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  PopupMenuButton popUpMenu(context, ThemeService notifier) {
    return PopupMenuButton(
        offset: const Offset(0, 35),
        child: const Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(Icons.brightness_medium_rounded, size: 30.0),
        ),
        onSelected: (theme) {
          BlocProvider.of<SettingCubit>(context).toggleTheme(notifier, theme);
        },
        itemBuilder: (ctx) => [
          popUpItem(notifier, ThemeServiceValues.light),
          popUpItem(notifier, ThemeServiceValues.dark),
          popUpItem(notifier, ThemeServiceValues.system)
        ]
    );
  }

  PopupMenuItem popUpItem(ThemeService notifier, String theme) {
    return PopupMenuItem(
      value: theme,
      child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: ClipOval(
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                        color: notifier.themeMode == theme ? Colors.green : Colors.grey
                    ),
                  )
              )
          ),
          Text(
            theme,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  PopupMenuButton popUpMenuColor(context, ThemeService notifier) {
    return PopupMenuButton(
        offset: const Offset(0, 35),
        child: const Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(Icons.color_lens, size: 30.0),
        ),
        onSelected: (color) {
          BlocProvider.of<SettingCubit>(context).toggleColor(notifier, color);
        },
        itemBuilder: (ctx) {
          List<PopupMenuItem> items = [];
          for(int i = 0; i < ThemeServiceValues.colorString.length; i++) {
            items.add(popUpItemColor(notifier, ThemeServiceValues.colorString[i]));
          }
          return items;
        }
    );
  }

  PopupMenuItem popUpItemColor(ThemeService notifier, String theme) {
    return PopupMenuItem(
      value: theme,
      child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: ClipOval(
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                        color: notifier.colorSeed == theme ? Colors.green : Colors.grey
                    ),
                  )
              )
          ),
          Text(
            theme,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  PopupMenuButton popUpMenuLanguage(context, LanguageService notifier) {
    return PopupMenuButton(
        offset: const Offset(0, 35),
        child: const Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(Icons.language, size: 30.0),
        ),
        onSelected: (language) {
          BlocProvider.of<SettingCubit>(context).toggleLanguage(notifier, language);
        },
        itemBuilder: (ctx) {
          List<PopupMenuItem> items = [];
          for(int i = 0; i < LanguageServiceValues.localeString.length; i++) {
            items.add(popUpItemLanguage(notifier, LanguageServiceValues.localeString[i]));
          }
          return items;
        }
    );
  }

  PopupMenuItem popUpItemLanguage(LanguageService notifier, String language) {
    return PopupMenuItem(
      value: language,
      child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: ClipOval(
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                        color: notifier.language == language ? Colors.green : Colors.grey
                    ),
                  )
              )
          ),
          Text(
            language,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeService, LanguageService> (
        builder: (context, ThemeService themeService, LanguageService languageService, child) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme
                    .of(context)
                    .colorScheme
                    .inversePrimary,
                title: Text(widget.title),
                actions: [
                  popUpMenuLanguage(context, languageService),
                  popUpMenuColor(context, themeService),
                  popUpMenu(context, themeService),
                ],
              ),
              body: const SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
              )
          );
        }
    );
  }

}


