import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/data/models/movie.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_image/network.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import '../../core/constant/routes_values.dart';
import '../../core/utils/color_utils.dart';
import 'dart:async';

import 'cubit/tmdb_cubit.dart';

class TMDBListWrapperProvider extends StatelessWidget {
  const TMDBListWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TMDBCubit>(),
      child: const TMDBListPage(title: "TMDB List"),
    );
  }
}

class TMDBListPage extends StatefulWidget {
  const TMDBListPage({super.key, required this.title});
  final String title;

  @override
  State<TMDBListPage> createState() => _TMDBListPageState();
}

class _TMDBListPageState extends State<TMDBListPage> {

  final PagingController<int, Movie> pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      fetchData(pageKey);
    });
    super.initState();
  }

  Future<void> fetchData(int pageKey) async {
    try {
      Map<String, dynamic> movieQuery = {
        'page': pageKey
      };
      final newItems = await BlocProvider.of<TMDBCubit>(context).getMovieTrending("day", movieQuery);
      final nextPageKey = pageKey + 1;
      pagingController.appendPage(newItems, nextPageKey);
    } catch (error) {
      pagingController.error = error;
    }
  }

  void favoriteList () {
    Navigator.pushNamed(context, RoutesValues.tmdbFavorite);
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

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
                    padding: const EdgeInsets.only(right: 12),
                    child: IconButton(
                      icon: const Icon(
                          Icons.favorite_outline,
                          size: 26
                      ),
                      tooltip: 'List Favorite',
                      onPressed: favoriteList,
                    ),
                  )
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () => Future.sync(
                      () => pagingController.refresh(),
                ),
                child: PagedListView<int, Movie>(
                  pagingController: pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Movie>(
                    itemBuilder: (context, item, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesValues.tmdbDetail, arguments: item.id);
                        },
                        title: Text(
                          '${item.title}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorUtils().getMaterialColor(Theme.of(context).colorScheme.primary).shade700
                          ),
                        ),
                        subtitle: Text(
                          '${item.overview}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImageWithRetry(item.getPoster()),
                        ),
                      );
                    },
                    // firstPageErrorIndicatorBuilder: (context) {
                    //   return TextButton(onPressed: () => pagingController.retryLastFailedRequest(), child: const Text("Reload First Data"));
                    // }
                    // newPageErrorIndicatorBuilder: (context) {
                    //   return TextButton(onPressed: () => pagingController.retryLastFailedRequest(), child:  const Text("Reload New Data"));
                    // }
                  ),
                )
              )
          );
        }
    );
  }


}
