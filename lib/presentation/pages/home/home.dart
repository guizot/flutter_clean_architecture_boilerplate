import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/utils/theme_service_values.dart';
import 'package:flutter_clean_architecture/presentation/pages/home/cubit/home_cubit.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import '../../core/services/theme_service.dart';

class HomeWrapperProvider extends StatelessWidget {
  const HomeWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>(),
      child: const HomePage(title: "Flutter Clean Architecture"),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PopupMenuButton popUpMenu(context, ThemeService notifier) {
    return PopupMenuButton(
          offset: const Offset(0, 35),
          child: const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.brightness_medium_rounded, size: 30.0),
          ),
          onSelected: (theme) {
            BlocProvider.of<HomeCubit>(context).toggleTheme(notifier, theme);
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

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService> (
        builder: (context, ThemeService notifier, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme
                  .of(context)
                  .colorScheme
                  .inversePrimary,
              title: Text(widget.title),
              actions: [
                popUpMenu(context, notifier),
              ],
            ),
            body: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [ ],
                )
            ),
          );
        }
    );
  }

}


