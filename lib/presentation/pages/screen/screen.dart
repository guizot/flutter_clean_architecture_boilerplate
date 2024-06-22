import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import '../../core/services/screen_size_service.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import 'cubit/screen_cubit.dart';

class ScreenWrapperProvider extends StatelessWidget {
  const ScreenWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ScreenCubit>(),
      child: const ScreenPage(title: "Screen Size"),
    );
  }
}

class ScreenPage extends StatefulWidget {
  const ScreenPage({super.key, required this.title});
  final String title;

  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {

  @override
  Widget build(BuildContext context) {
    var ss = sl<ScreenSizeService>()..init(context);
    return Consumer2<ThemeService, LanguageService> (
        builder: (context, ThemeService themeService, LanguageService languageService, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
            ),
            body: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: Row(
                children: [
                  Visibility(
                    visible: ss.sidebarShowHide,
                    child: Container(
                      width: ss.sidebarWidth,
                      height: ss.screenSize.height,
                      margin: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: ListView.builder(
                        itemCount: 15,
                        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 60,
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Center(
                              child: Text(
                                  'Item ${index+1}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.primary.toMaterialColor().shade700
                                  )
                              ),
                            ),
                          );
                        },
                      )
                    )
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: 25,
                      padding: const EdgeInsets.all(16.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ss.gridCrossAxisCount,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Center(
                            child: Text(
                                'Item ${index+1}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary.toMaterialColor().shade700
                                )
                            ),
                          ),
                        );
                      },
                    )
                  )
                ],
              )
            )
          );
        }
    );
  }

}