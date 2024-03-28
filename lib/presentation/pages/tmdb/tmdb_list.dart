import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/data/models/movie.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import '../../core/constant/routes_values.dart';
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
  final ScrollController scrollController = ScrollController();
  bool isVisible = true;

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      fetchData(pageKey);
    });
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (isVisible) setState(() => isVisible = false);
      } else {
        if (!isVisible) setState(() => isVisible = true);
      }
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
    scrollController.dispose();
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
              body: Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () => Future.sync(
                          () => pagingController.refresh(),
                    ),
                    child: PagedListView<int, Movie>(
                      padding: const EdgeInsets.only(top: 60.0),
                      scrollController: scrollController,
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
                                  color: Theme.of(context).colorScheme.primary.toMaterialColor().shade700
                              ),
                            ),
                            subtitle: Text(
                              '${item.overview}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(item.getPoster()),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: isVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      height: 60.0,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const Text('I appear when you scroll up!'),
                    ),
                  ),
                ],
              )
          );
        }
    );
  }


}
