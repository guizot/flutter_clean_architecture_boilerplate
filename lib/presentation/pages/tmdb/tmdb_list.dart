
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/data/models/movie.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_clean_architecture/presentation/core/utils/date_time_utils.dart';
import 'package:flutter_clean_architecture/presentation/core/widget/tmdb/item_tmdb.dart';
import 'package:glass/glass.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import '../../core/constant/routes_values.dart';
import 'dart:async';
import '../../core/widget/list_skeleton.dart';
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

  final TextEditingController searchController = TextEditingController();
  List<String> years = DateTimeUtils().generatePastYearsList(40);
  String? selectedYears;
  String? selectedQuery;
  int pageSize = 20;

  Timer? debounceController;
  bool get isSearch => (
      selectedYears != null &&
      selectedYears != "" ||
      selectedQuery != null &&
      selectedQuery != ""
  );

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      if(!isSearch) {
        fetchData(pageKey);
      } else {
        refreshData(pageKey);
      }
    });
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (isVisible) setState(() => isVisible = false);
      }
      else {
        if (!isVisible) setState(() => isVisible = true);
      }
    });
    super.initState();
  }

  Future<void> fetchData(int pageKey) async {
    try {
      List<Movie> newItems = [];
      if(!isSearch) {
        Map<String, dynamic> movieQuery = {
          'page': pageKey
        };
        newItems = await BlocProvider.of<TMDBCubit>(context).getMovieTrending("day", movieQuery);
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      } else {
        Map<String, dynamic> movieQuery = {
          'page': pageKey,
          'primary_release_year': selectedYears,
          'query': selectedQuery
        };
        newItems = await BlocProvider.of<TMDBCubit>(context).searchMovie(movieQuery);
        final isLastPage = newItems.length < pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(newItems, nextPageKey);
        }
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<void> refreshData (int pageKey) async {
    if (debounceController?.isActive ?? false) debounceController?.cancel();
    debounceController = Timer(const Duration(milliseconds: 750), () {
      fetchData(pageKey);
    });
  }

  void favoriteList () {
    Navigator.pushNamed(context, RoutesValues.tmdbFavorite);
  }

  @override
  void dispose() {
    pagingController.dispose();
    scrollController.dispose();
    searchController.dispose();
    debounceController?.cancel();
    super.dispose();
  }

  Widget searchWrapper(Widget child) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        width: double.infinity,
        child: child
    ).asGlass(
        blurX: 10.0,
        blurY: 10.0,
        tintColor: Theme.of(context).colorScheme.primary
    );
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
                      padding: const EdgeInsets.only(top: 75.0),
                      scrollController: scrollController,
                      pagingController: pagingController,
                      builderDelegate: PagedChildBuilderDelegate<Movie>(
                        itemBuilder: (context, item, index) {
                          return ItemTMDB(
                              title: item.title ?? "",
                              subtitle: item.overview ?? "",
                              url: item.getPoster(),
                              onTap: () {
                                Navigator.pushNamed(context, RoutesValues.tmdbDetail, arguments: item.id);
                              }
                          );
                        },
                        firstPageProgressIndicatorBuilder: (context) {
                          return const ListSkeleton();
                        }
                      )
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: isVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: searchWrapper(
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 2,
                            child: TextField(
                              controller: searchController,
                              cursorRadius: const Radius.circular(24),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Theme.of(context).colorScheme.background.toMaterialColor().shade300,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    borderSide: BorderSide.none
                                ),
                                hintText: 'Search..',
                                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                isDense: true,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  selectedQuery = value;
                                });
                                pagingController.refresh();
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Flexible(
                            flex: 1,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background.toMaterialColor().shade300,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                                child: DropdownButton<String>(
                                  value: selectedYears,
                                  items: years.map((String animal) {
                                    return DropdownMenuItem<String>(
                                      value: animal,
                                      child: Text(animal),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedYears = newValue;
                                    });
                                    pagingController.refresh();
                                  },
                                  hint: const Text('Year'),
                                  underline: Container(),
                                  isDense: true,
                                  isExpanded: true,
                                ),
                              ),
                            ),
                          ),
                          isSearch
                          ? Row(
                            children: [
                              const SizedBox(
                                width: 8.0,
                              ),
                              Container(
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.background.toMaterialColor().shade300,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: IconButton(
                                  style: const ButtonStyle(
                                    padding: MaterialStatePropertyAll(EdgeInsets.zero),
                                    visualDensity: VisualDensity.compact
                                  ),
                                  icon: const Icon(
                                      Icons.close,
                                      size: 26.0
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      selectedYears = null;
                                      selectedQuery = null;
                                      searchController.clear();
                                    });
                                    pagingController.refresh();
                                  },
                                  visualDensity: VisualDensity.compact,
                                ),
                              ),
                            ],
                          )
                          : const Row()
                        ],
                      )
                    )
                  ),
                ],
              ),
            floatingActionButton: FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () {
                scrollController.animateTo(
                  scrollController.position.minScrollExtent,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 500),
                );
              },
              child: const Icon(
                Icons.keyboard_arrow_up,
                size: 26,
              ),
            ),
          );
        }
    );
  }


}