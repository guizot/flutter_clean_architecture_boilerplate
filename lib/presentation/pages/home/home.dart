import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_clean_architecture/presentation/core/handler/navigation_handler.dart';
import 'package:flutter_clean_architecture/presentation/core/widget/common_list_item.dart';
import 'package:flutter_clean_architecture/presentation/pages/home/cubit/home_cubit.dart';
import '../../core/services/notification_service.dart';
import '../../core/model/common_list_model.dart';
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

  @override
  void initState() {
    super.initState();
    NotificationService().init(context);
  }

  @override
  void dispose() {
    NotificationService().dispose();
    super.dispose();
  }

  List<CommonListModel> lists = [
    CommonListModel(
      title: "Github List",
      subtitle: "list of favorite github users using dio, retrofit & hive",
      tap: (context) {
        NavigationHandler().navigate(
          context: context,
          route: RoutesValues.githubList
        );
      }
    ),
    CommonListModel(
      title: "TMDB List",
      subtitle: "list of trending movies using dio, retrofit & sqlite",
      tap: (context) {
        Navigator.pushNamed(context, RoutesValues.tmdbList);
      }
    ),
    CommonListModel(
        title: "Firebase Notes App",
        subtitle: "example of firabase database firestore",
        tap: (context) {
          NavigationHandler().navigate(
              context: context,
              route: RoutesValues.notes
          );
        }
    ),
    CommonListModel(
        title: "GraphQL Notes App",
        subtitle: "example of GraphQL CRUD",
        tap: (context) {
          NavigationHandler().navigate(
              context: context,
              route: RoutesValues.notesGraphQL
          );
        }
    ),
    CommonListModel(
      title: "Expanded Panel List",
      subtitle: "list dynamic expanded panel",
      tap: (context) {
        Navigator.pushNamed(context, RoutesValues.expanded);
      }
    ),
    CommonListModel(
      title: "Picker File",
      subtitle: "picker image and file implementation",
      tap: (context) {
        Navigator.pushNamed(context, RoutesValues.picker);
      }
    ),
    CommonListModel(
        title: "Dialog Designer",
        subtitle: "alert dialog, bottom sheet, toast and other dialog implementation",
        tap: (context) {
          Navigator.pushNamed(context, RoutesValues.dialog);
        }
    ),
    CommonListModel(
      title: "Form Designer",
      subtitle: "dynamic form creation example",
      tap: (context) {
        Navigator.pushNamed(context, RoutesValues.form);
      }
    ),
    CommonListModel(
      title: "Web View",
      subtitle: "the example of web view",
      tap: (context) {
        Navigator.pushNamed(context, RoutesValues.webView, arguments: "https://www.google.com/");
      }
    ),
    CommonListModel(
      title: "Staggered List View",
      subtitle: "the example of staggered list and others",
      tap: (context) {
        Navigator.pushNamed(context, RoutesValues.staggered);
      }
    ),
    CommonListModel(
      title: "Coach Mark",
      subtitle: "the example of coach mark tutorial",
      tap: (context) {
        Navigator.pushNamed(context, RoutesValues.coachMark);
      }
    ),
    CommonListModel(
      title: "Screen Size",
      subtitle: "responsive ui screen size implementation",
      tap: (context) {
        Navigator.pushNamed(context, RoutesValues.screen);
      }
    ),
    CommonListModel(
        title: "Activity Stack",
        subtitle: "example of activity stack",
        tap: (context) {
          NavigationHandler().navigate(
              context: context,
              route: RoutesValues.activityStack
          );
        }
    ),
    CommonListModel(
      title: "Image Extension",
      subtitle: "image manipulation implementation",
      tap: (context) {
        Navigator.pushNamed(context, RoutesValues.image);
      }
    ),
    CommonListModel(
        title: "Notification",
        subtitle: "example of notification system",
        tap: (context) async {
          Navigator.pushNamed(context, RoutesValues.notification);
        }
    ),
    CommonListModel(
        title: "Product Detail",
        subtitle: "example of deep linking",
        tap: (context) async {
          Navigator.pushNamed(context, RoutesValues.product, arguments: "123456");
        }
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeService, LanguageService> (
        builder: (context, ThemeService themeService, LanguageService languageService, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: IconButton(
                    icon: const Icon(Icons.settings, size: 30.0),
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
                  child: CommonListItem(
                    title: lists[index].title,
                    subtitle: lists[index].subtitle,
                    onTap: lists[index].tap,
                  )
                );
              },
            )
          );
        }
    );
  }

}