import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_image/network.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../data/models/user.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import '../../core/constant/routes_values.dart';
import '../../core/utils/color_utils.dart';
import 'cubit/github_cubit.dart';
import 'cubit/github_state.dart';

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

class _GithubListPageState extends State<GithubListPage> {

  final PagingController<int, User> _pagingController = PagingController(firstPageKey: 1);
  static const _pageSize = 10;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      Map<String, dynamic> userQuery = {
        'q': 'followers:>10000',
        'per_page': _pageSize,
        'page': pageKey
      };
      final newItems = await BlocProvider.of<GithubCubit>(context).searchUser(userQuery);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Widget loadList(BuildContext context, GithubCubitState state) {
    if (state is GithubInitial) {
      return Container();
    }
    else if (state is GithubStateLoading) {
      return const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading..')
          ],
        ),
      );
    }
    else if (state is GithubStateLoaded) {
      return PagedListView<int, User>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<User>(
          itemBuilder: (context, item, index) {
            return ListTile(
              onTap: () {
                Navigator.pushNamed(context, RoutesValues.githubDetail, arguments: item.login);
              },
              title: Text(
                '${item.login}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorUtils().getMaterialColor(Theme.of(context).colorScheme.primary).shade700
                ),
              ),
              subtitle: Text(
                '${item.htmlUrl}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              leading: CircleAvatar(
                backgroundImage: NetworkImageWithRetry('${item.avatarUrl}'),
              ),
            );
          },
        ),
      );
    }
    else if (state is GithubStateError) {
      return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              state.message,
              textAlign: TextAlign.center,
            ),
          )
      );
    }
    return Container();
  }

  @override
  void dispose() {
    _pagingController.dispose();
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
                title: Text(widget.title),
              ),
              body: PagedListView<int, User>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<User>(
                  itemBuilder: (context, item, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesValues.githubDetail, arguments: item.login);
                      },
                      title: Text(
                        '${item.login}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorUtils().getMaterialColor(Theme.of(context).colorScheme.primary).shade700
                        ),
                      ),
                      subtitle: Text(
                        '${item.htmlUrl}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImageWithRetry('${item.avatarUrl}'),
                      ),
                    );
                  },
                ),
              )
              // body: BlocBuilder<GithubCubit, GithubCubitState>(
              //   builder: (context, state) {
              //     return loadList(context, state);
              //   },
              // )
          );
        }
    );
  }


}
