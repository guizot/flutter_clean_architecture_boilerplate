import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toastification/toastification.dart';
import '../../core/languages/languages.dart';
import '../../core/services/permission_service.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../core/constant/language_service_values.dart';
import '../../core/constant/theme_service_values.dart';
import '../../core/utils/string_utils.dart';
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

    Column itemSetting(String title, Widget widget) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
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
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),
                    ),
                    const SizedBox(height: 12),
                    widget
                  ],
                ),
              )
          ),
          const SizedBox(height: 16),
        ],
      );
    }

    void showToast(String title, String description) {
      toastification.show(
        context: context,
        title: Text(title),
        description: Text(description),
        style: ToastificationStyle.flat,
        primaryColor: Theme.of(context).chipTheme.selectedColor,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        autoCloseDuration: const Duration(seconds: 5),
      );
    }

    return Consumer2<ThemeService, LanguageService> (
        builder: (context, ThemeService themeService, LanguageService languageService, child) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: Text(widget.title),
                actions: const [],
              ),
              body: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  itemSetting(
                    Languages.of(context)!.themeMode,
                    Wrap(
                        spacing: 10,
                        runSpacing: 0,
                        children: List.generate(ThemeServiceValues.themeString.length, (index) {
                          return FilterChip(
                            label: Text(ThemeServiceValues.themeString[index]),
                            backgroundColor: Theme.of(context).highlightColor,
                            onSelected: (bool value) {
                              BlocProvider.of<SettingCubit>(context).toggleTheme(themeService, ThemeServiceValues.themeString[index]);
                            },
                            selected: themeService.themeMode == ThemeServiceValues.themeString[index] ? true : false,
                            side: const BorderSide(
                                style: BorderStyle.none
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)
                            ),
                          );
                        }
                        )
                    )
                  ),
                  itemSetting(
                    Languages.of(context)!.themeColor,
                    Wrap(
                        spacing: 10,
                        runSpacing: 0,
                        children: List.generate(ThemeServiceValues.colorString.length, (index) {
                          return FilterChip(
                            label: Text(ThemeServiceValues.colorString[index]),
                            backgroundColor: Theme.of(context).highlightColor,
                            onSelected: (bool value) {
                              BlocProvider.of<SettingCubit>(context).toggleColor(themeService, ThemeServiceValues.colorString[index]);
                            },
                            selected: themeService.colorSeed == ThemeServiceValues.colorString[index] ? true : false,
                            side: const BorderSide(
                                style: BorderStyle.none
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)
                            ),
                          );
                        }
                        )
                    )
                  ),
                  itemSetting(
                    Languages.of(context)!.language,
                    Wrap(
                        spacing: 10,
                        runSpacing: 0,
                        children: List.generate(LanguageServiceValues.localeString.length, (index) {
                          return FilterChip(
                            label: Text(LanguageServiceValues.localeString[index]),
                            backgroundColor: Theme.of(context).highlightColor,
                            onSelected: (bool value) {
                              BlocProvider.of<SettingCubit>(context).toggleLanguage(languageService, LanguageServiceValues.localeString[index]);
                            },
                            selected: languageService.language == LanguageServiceValues.localeString[index] ? true : false,
                            side: const BorderSide(
                                style: BorderStyle.none
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)
                            ),
                          );
                        }
                        )
                    )
                  ),
                  itemSetting(
                    Languages.of(context)!.fonts,
                    Wrap(
                        spacing: 10,
                        runSpacing: 0,
                        children: List.generate(ThemeServiceValues.fontString.length, (index) {
                          return FilterChip(
                            label: Text(ThemeServiceValues.fontString[index]),
                            backgroundColor: Theme.of(context).highlightColor,
                            onSelected: (bool value) {
                              BlocProvider.of<SettingCubit>(context).toggleFont(themeService, ThemeServiceValues.fontString[index]);
                            },
                            selected: themeService.fontFamily == ThemeServiceValues.fontString[index] ? true : false,
                            side: const BorderSide(
                                style: BorderStyle.none
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)
                            ),
                          );
                        }
                        )
                    )
                  ),
                  itemSetting(
                    Languages.of(context)!.permission,
                    Wrap(
                        spacing: 10,
                        runSpacing: 0,
                        children: List.generate(Permission.values.length, (index) {
                          return FilterChip(
                            label: SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      StringUtils().convertToTitleCase(Permission.values[index].toString().replaceAll("Permission.", "")),
                                    ),
                                    FutureBuilder<PermissionStatus>(
                                      future: Permission.values[index].status,
                                      builder: (BuildContext context, AsyncSnapshot<PermissionStatus> snapshot) {
                                        String status = snapshot.data.toString().replaceAll("PermissionStatus.", "");
                                        String sts = status.substring(0, 1).toUpperCase() + status.substring(1);
                                        return Text(
                                          sts,
                                          style: TextStyle(
                                            color: sts == 'Granted' ? Colors.green : Colors.red
                                          ),
                                        );
                                      }
                                    ),
                                  ],
                                )
                            ),
                            backgroundColor: Theme.of(context).highlightColor,
                            onSelected: (bool value) async {
                              String permissionName = StringUtils().convertToTitleCase(Permission.values[index].toString().replaceAll("Permission.", ""));
                              String permission = await PermissionService().checkPermissionString(Permission.values[index]);
                              showToast(permissionName, permission);
                            },
                            selected: false,
                            side: const BorderSide(
                                style: BorderStyle.none
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)
                            ),
                          );
                        }
                        )
                    )
                  ),
                ],
              )
          );
        }
    );
  }

}