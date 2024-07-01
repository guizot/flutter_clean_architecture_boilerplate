import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/pages/expanded/expanded.dart';
import 'package:flutter_clean_architecture/presentation/pages/form/form.dart';
import 'package:flutter_clean_architecture/presentation/pages/github/github_detail.dart';
import 'package:flutter_clean_architecture/presentation/pages/github/github_favorite.dart';
import 'package:flutter_clean_architecture/presentation/pages/github/github_list.dart';
import 'package:flutter_clean_architecture/presentation/pages/home/home.dart';
import 'package:flutter_clean_architecture/presentation/pages/image/image.dart';
import 'package:flutter_clean_architecture/presentation/pages/product/product.dart';
import 'package:flutter_clean_architecture/presentation/pages/setting/setting.dart';
import 'package:flutter_clean_architecture/presentation/pages/webview/webview.dart';
import '../../pages/coachmark/coachmark.dart';
import '../../pages/dialog/dialog.dart';
import '../../pages/picker/picker.dart';
import '../../pages/screen/screen.dart';
import '../../pages/staggered/staggered.dart';
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
      case RoutesValues.picker:
        return MaterialPageRoute(builder: (_) => const PickerWrapperProvider());
      case RoutesValues.webView:
        var url = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => WebViewWrapperProvider(url: url));
      case RoutesValues.coachMark:
        return MaterialPageRoute(builder: (_) => const CoachMarkWrapperProvider());
      case RoutesValues.staggered:
        return MaterialPageRoute(builder: (_) => const StaggeredWrapperProvider());
      case RoutesValues.form:
        return MaterialPageRoute(builder: (_) => const FormWrapperProvider());
      case RoutesValues.dialog:
        return MaterialPageRoute(builder: (_) => const DialogWrapperProvider());
      case RoutesValues.product:
        var id = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => ProductWrapperProvider(id: id));
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