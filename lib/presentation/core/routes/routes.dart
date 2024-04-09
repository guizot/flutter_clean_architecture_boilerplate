import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/pages/expanded/expanded.dart';
import 'package:flutter_clean_architecture/presentation/pages/github/github_detail.dart';
import 'package:flutter_clean_architecture/presentation/pages/github/github_favorite.dart';
import 'package:flutter_clean_architecture/presentation/pages/github/github_list.dart';
import 'package:flutter_clean_architecture/presentation/pages/home/home.dart';
import 'package:flutter_clean_architecture/presentation/pages/image/image.dart';
import 'package:flutter_clean_architecture/presentation/pages/setting/setting.dart';
import '../../pages/screen/screen.dart';
import '../../pages/tmdb/tmdb_detail.dart';
import '../../pages/tmdb/tmdb_favorite.dart';
import '../../pages/tmdb/tmdb_list.dart';
import '../constant/routes_values.dart';

class Routes {

  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case RoutesValues.home:
        return MaterialPageRoute(builder: (_) => const HomeWrapperProvider());
      case RoutesValues.setting:
        return MaterialPageRoute(builder: (_) => const SettingWrapperProvider());
      case RoutesValues.githubList:
        return MaterialPageRoute(builder: (_) => const GithubListWrapperProvider());
      case RoutesValues.githubDetail:
        var id = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => GithubDetailWrapperProvider(id: id));
      case RoutesValues.githubFavorite:
        return MaterialPageRoute(builder: (_) => const GithubFavoriteWrapperProvider());
      case RoutesValues.tmdbList:
        return MaterialPageRoute(builder: (_) => const TMDBListWrapperProvider());
      case RoutesValues.tmdbDetail:
        var id = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => TMDBDetailWrapperProvider(id: id));
      case RoutesValues.tmdbFavorite:
        return MaterialPageRoute(builder: (_) => const TMDBFavoriteWrapperProvider());
      case RoutesValues.screen:
        return MaterialPageRoute(builder: (_) => const ScreenWrapperProvider());
      case RoutesValues.image:
        return MaterialPageRoute(builder: (_) => const ImageWrapperProvider());
      case RoutesValues.expanded:
        return MaterialPageRoute(builder: (_) => const ExpandedWrapperProvider());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            appBar: AppBar(title: const Text("Error")),
            body: const Center(child: Text('Error page')),
          );
        });
    }
  }

}