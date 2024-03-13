import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_image/network.dart';
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

  List<User>? gitUsers;

  @override
  void initState() {
    super.initState();
    getPopularGithubUser();
  }

  void getPopularGithubUser() async {
    List<User>? lists = await BlocProvider.of<GithubCubit>(context).searchUser("");
    setState(()  {
      gitUsers = lists;
    });
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
      return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: gitUsers != null ? gitUsers!.length : 0 ,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {
                Navigator.pushNamed(context, RoutesValues.githubDetail, arguments: gitUsers![index].login);
              },
              title: Text(
                '${gitUsers![index].login}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorUtils().getMaterialColor(Theme.of(context).colorScheme.primary).shade700
                ),
              ),
              subtitle: Text(
                '${gitUsers![index].html_url}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              leading: CircleAvatar(
                backgroundImage: NetworkImageWithRetry('${gitUsers![index].avatar_url}'),
              ),
            );
          }
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
              body: BlocBuilder<GithubCubit, GithubCubitState>(
                builder: (context, state) {
                  return loadList(context, state);
                },
              )
          );
        }
    );
  }


}

