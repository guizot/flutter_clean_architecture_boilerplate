import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/domain/entities/user_github.dart';
import 'package:flutter_clean_architecture/presentation/core/extension/color_extension.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import '../../core/constant/routes_values.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import 'cubit/github_cubit.dart';
import 'cubit/github_state.dart';

class GithubFavoriteWrapperProvider extends StatelessWidget {
  const GithubFavoriteWrapperProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GithubCubit>(),
      child: const GithubFavoritePage(title: "Github Favorite"),
    );
  }
}

class GithubFavoritePage extends StatefulWidget {
  const GithubFavoritePage({super.key, required this.title});
  final String title;

  @override
  State<GithubFavoritePage> createState() => _GithubFavoritePageState();
}

class _GithubFavoritePageState extends State<GithubFavoritePage> {

  List<UserGithub>? users;

  @override
  void initState() {
    getUserLocal();
    super.initState();
  }

  /// REGION: LOCAL DATA SOURCE
  void getUserLocal() async {
    List<UserGithub> users = BlocProvider.of<GithubCubit>(context).getAllUserLocal();
    setState(() {
      this.users = users;
    });
  }

  Widget loadList(BuildContext context, GithubCubitState state) {
    if (state is GithubInitial) {
      return Center(
          child: Container()
      );
    }
    else if (state is GithubStateLoading) {
      return const Center(
          child: SizedBox(
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Loading..')
              ],
            ),
          )
      );
    }
    else if (state is GithubStateLoaded) {
      return ListView.builder(
          itemCount: users != null ? users!.length : 0 ,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {
                Navigator.pushNamed(
                    context,
                    RoutesValues.githubDetail,
                    arguments: users![index].login
                ).then((value) {
                  getUserLocal();
                });
              },
              title: Text(
                '${users![index].login}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary.toMaterialColor().shade700
                ),
              ),
              subtitle: Text(
                '${users![index].htmlUrl}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              leading: CircleAvatar(
                backgroundImage: NetworkImage('${users![index].avatarUrl}'),
              ),
            );
          }
        );
    }
    else if (state is GithubStateEmpty) {
      return const Center(
          child: Text('Empty..')
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
    else {
      return Center(
          child: Container()
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeService, LanguageService> (
        builder: (context, ThemeService themeService, LanguageService languageService, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title)
            ),
            body: BlocBuilder<GithubCubit, GithubCubitState>(
              builder: (context, state) => loadList(context, state)
            )
          );
        }
    );
  }

}