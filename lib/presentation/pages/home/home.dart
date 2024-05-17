import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_clean_architecture/presentation/core/widget/home/item_home.dart';
import 'package:flutter_clean_architecture/presentation/pages/home/cubit/home_cubit.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import '../../core/constant/routes_values.dart';

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

  List<Map<String, dynamic>> lists = [
    {
      "title": "Github List",
      "subtitle": "list of favorite github users using dio, retrofit & hive",
      "tap": (context) {
        Navigator.pushNamed(context, RoutesValues.githubList);
      }
    },
    {
      "title": "TMDB List",
      "subtitle": "list of trending movies using dio, retrofit & sqlite",
      "tap": (context) {
        Navigator.pushNamed(context, RoutesValues.tmdbList);
      }
    },
    {
      "title": "Expanded Panel List",
      "subtitle": "list dynamic expanded panel",
      "tap": (context) {
        Navigator.pushNamed(context, RoutesValues.expanded);
      }
    },
    {
      "title": "Picker File",
      "subtitle": "picker image and file implementation",
      "tap": (context) {
        Navigator.pushNamed(context, RoutesValues.picker);
      }
    },
    {
      "title": "Screen Size",
      "subtitle": "responsive ui screen size implementation",
      "tap": (context) {
        Navigator.pushNamed(context, RoutesValues.screen);
      }
    },
    {
      "title": "Image Extension",
      "subtitle": "image manipulation implementation",
      "tap": (context) {
        Navigator.pushNamed(context, RoutesValues.image);
      }
    },
    {
      "title": "Web View",
      "subtitle": "the example of web view",
      "tap": (context) {
        Navigator.pushNamed(context, RoutesValues.webView, arguments: "https://www.google.com/");
      }
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeService, LanguageService> (
        builder: (context, ThemeService themeService, LanguageService languageService, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: IconButton(
                    icon: const Icon(Icons.settings, size: 30.0,),
                    tooltip: 'Setting',
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesValues.setting);
                    },
                  ),
                )
              ],
            ),
            body: ListView.builder(
              shrinkWrap: true,
              itemCount: lists.length,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16), // Adjust border radius as needed
                    border: Border.all(color: Colors.grey), // Add border color
                  ),
                  child: ItemHome(
                    title: lists[index]["title"],
                    subtitle: lists[index]["subtitle"],
                    onTap: lists[index]["tap"],
                  )
                );
              },
            )
          );
        }
    );
  }

}