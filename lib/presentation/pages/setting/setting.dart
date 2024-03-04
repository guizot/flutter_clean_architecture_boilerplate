import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import '../../core/languages/languages.dart';
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
                actions: const [],
              ),
              body: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  ClipPath(
                    clipper: const ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6))
                        )
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).hoverColor
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Languages.of(context)!.themeMode,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 36,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: ThemeServiceValues.themeString.length,
                              separatorBuilder: (_, __) => const Divider(),
                              itemBuilder: (context, int index) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<SettingCubit>(context).toggleTheme(themeService, ThemeServiceValues.themeString[index]);
                                    },
                                    child: ClipPath(
                                      clipper: const ShapeBorderClipper(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(25))
                                          )
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                        decoration: BoxDecoration(
                                            color: themeService.themeMode == ThemeServiceValues.themeString[index] ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).highlightColor
                                        ),
                                        child: Text(ThemeServiceValues.themeString[index]),
                                      ),
                                    ),
                                  )
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                  const SizedBox(height: 16),
                  ClipPath(
                      clipper: const ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(6))
                          )
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Theme.of(context).hoverColor
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Languages.of(context)!.themeColor,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 36,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: ThemeServiceValues.colorString.length,
                                separatorBuilder: (_, __) => const Divider(),
                                itemBuilder: (context, int index) {
                                  return Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      child: GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<SettingCubit>(context).toggleColor(themeService, ThemeServiceValues.colorString[index]);
                                        },
                                        child: ClipPath(
                                          clipper: const ShapeBorderClipper(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(25))
                                              )
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                            decoration: BoxDecoration(
                                                color: themeService.colorSeed == ThemeServiceValues.colorString[index] ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).highlightColor
                                            ),
                                            child: Text(ThemeServiceValues.colorString[index]),
                                          ),
                                        )
                                      )
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                  const SizedBox(height: 16),
                  ClipPath(
                      clipper: const ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(6))
                          )
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Theme.of(context).hoverColor
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Languages.of(context)!.language,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 36,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: LanguageServiceValues.localeString.length,
                                separatorBuilder: (_, __) => const Divider(),
                                itemBuilder: (context, int index) {
                                  return Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      child: GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<SettingCubit>(context).toggleLanguage(languageService, LanguageServiceValues.localeString[index]);
                                        },
                                        child: ClipPath(
                                          clipper: const ShapeBorderClipper(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(25))
                                              )
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                            decoration: BoxDecoration(
                                                color: languageService.language == LanguageServiceValues.localeString[index] ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).highlightColor
                                            ),
                                            child: Text(LanguageServiceValues.localeString[index]),
                                          ),
                                        )
                                      )
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                  const SizedBox(height: 16),
                ],
              )
          );
        }
    );
  }

}


