import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_clean_architecture/presentation/core/widget/github/item_github.dart';
import 'package:flutter_clean_architecture/presentation/core/widget/list_skeleton.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../data/models/user.dart';
import '../../core/mixins/share_mixin.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import '../../core/constant/routes_values.dart';
import 'cubit/github_cubit.dart';
import 'dart:async';

class GithubListWrapperProvider extends StatelessWidget {
  const GithubListWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GithubCubit>(),
      child: const GithubListPage(title: "Github List"),
    );
  }
}

class GithubListPage extends StatefulWidget {
  const GithubListPage({super.key, required this.title});
  final String title;

  @override
  State<GithubListPage> createState() => _GithubListPageState();
}

class _GithubListPageState extends State<GithubListPage> with ShareMixin {

  final TextEditingController searchController = TextEditingController();
  final PagingController<int, User> pagingController = PagingController(firstPageKey: 1);
  Timer? debounceController;
  bool isSearch = false;
  String queryName = '';
  int pageSize = 10;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      fetchData(pageKey);
    });
    searchController.addListener(() {
      refreshData();
    });
    super.initState();
  }

  Future<void> fetchData(int pageKey) async {
    try {
      Map<String, dynamic> userQuery = {
        'q': queryName == '' ? 'followers:>10000' : queryName,
        'per_page': pageSize,
        'page': pageKey
      };
      final newItems = await BlocProvider.of<GithubCubit>(context).searchUser(userQuery);
      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<void> refreshData () async {
    if (debounceController?.isActive ?? false) debounceController?.cancel();
    debounceController = Timer(const Duration(milliseconds: 750), () {
      queryName = searchController.text.toLowerCase();
      pagingController.refresh();
    });
  }

  void searchMode () {
    setState(() {
      isSearch = !isSearch;
    });
    if(!isSearch) {
      searchController.clear();
      focusNode.unfocus();
    } else {
      focusNode.requestFocus();
    }
  }

  void favoriteList () {
    Navigator.pushNamed(context, RoutesValues.githubFavorite);
  }

  @override
  void dispose() {
    pagingController.dispose();
    searchController.dispose();
    debounceController?.cancel();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeService, LanguageService> (
        builder: (context, ThemeService themeService, LanguageService languageService, child) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme
                    .of(context)
                    .colorScheme
                    .inversePrimary,
                title: isSearch ? TextField(
                  focusNode: focusNode,
                  controller: searchController,
                  cursorRadius: const Radius.circular(24),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none
                    ),
                    hintText: 'Search..',
                    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    isDense: true,
                  ),
                ) : Text(widget.title),
                actions: [
                  isSearch ? Container() : Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: IconButton(
                      icon: const Icon(
                          Icons.favorite_outline,
                          size: 26
                      ),
                      tooltip: 'List Favorite',
                      onPressed: favoriteList,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: IconButton(
                      icon: Icon(
                          isSearch ? Icons.close : Icons.search,
                          size: 26
                      ),
                      tooltip: isSearch ? 'Close' : 'Search',
                      onPressed: searchMode,
                    ),
                  ),
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () => Future.sync(
                      () => pagingController.refresh(),
                ),
                child: PagedListView<int, User>(
                  pagingController: pagingController,
                  builderDelegate: PagedChildBuilderDelegate<User>(
                    itemBuilder: (context, item, index) {
                      return Slidable(
                        key: ValueKey(index),
                        closeOnScroll: true,
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                shareText('GITHUB: ${item.login} - URL: ${item.htmlUrl}');
                              },
                              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                              icon: Icons.share,
                              label: 'Share',
                            ),
                          ],
                        ),
                        child: ItemGithub(
                          title: item.login ?? "",
                          subtitle: item.htmlUrl ?? "",
                          url: item.avatarUrl ?? "",
                          onTap: () => Navigator.pushNamed(context, RoutesValues.githubDetail, arguments: item.login)
                        )
                      );
                    },
                    firstPageProgressIndicatorBuilder: (context) {
                      return const ListSkeleton();
                    }
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