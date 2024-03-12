import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/data/models/movie.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_clean_architecture/presentation/core/languages/languages.dart';
import 'package:flutter_clean_architecture/presentation/pages/home/cubit/home_cubit.dart';
import 'package:flutter_clean_architecture/presentation/pages/home/cubit/home_state.dart';
import 'package:flutter_image/network.dart';
import '../../../data/models/user.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import '../../core/constant/routes_values.dart';
import '../../core/utils/color_utils.dart';

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

  List<User>? gitUsers;
  List<Movie>? movies;

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<HomeCubit>(context).getData();
    getPopularGithubUser();
    getMovieTrending();
  }

  void getPopularGithubUser() async {
    List<User>? lists = await BlocProvider.of<HomeCubit>(context).searchUser("");
    setState(()  {
      gitUsers = lists;
    });
    // if(gitUsers != null) {
    //   for(var i in gitUsers!) {
    //     print("USERS: ${i.toJson()}");
    //   }
    // }
  }

  void getMovieTrending() async {
    List<Movie>? lists = await BlocProvider.of<HomeCubit>(context).getMovieTrending("day");
    setState(()  {
      movies = lists;
    });
  }

  Widget contentLoaded() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Languages.of(context)!.title,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            Languages.of(context)!.description,
            style: const TextStyle(
                height: 1.5
            ),
          )
        ],
      ),
    );
  }

  Widget loadData(BuildContext context, HomeCubitState state) {
    if (state is HomeInitial) {
      return Container();
    }
    else if (state is HomeStateLoading) {
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
    else if (state is HomeStateLoaded) {
      return contentLoaded();
    }
    else if (state is HomeStateError) {
      return const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error')
          ],
        ),
      );
    }
    return Container();
  }

  Widget loadList(BuildContext context, HomeCubitState state) {
    if (state is HomeInitial) {
      return Container();
    }
    else if (state is HomeStateLoading) {
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
    else if (state is HomeStateLoaded) {
      return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: movies != null ? movies!.length : 0 ,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                '${movies![index].title}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorUtils().getMaterialColor(Theme.of(context).colorScheme.primary).shade700
                ),
              ),
              subtitle: Text(
                '${movies![index].overview}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              leading: CircleAvatar(
                backgroundImage: NetworkImageWithRetry(movies![index].getPoster()),
              ),
            );
          }
      );
    }
    else if (state is HomeStateError) {
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
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: IconButton(
                    icon: const Icon(Icons.settings, size: 30.0,),
                    tooltip: 'Setting',
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesValues.setting);
                    },
                  ),
                )
              ],
            ),
            body: BlocBuilder<HomeCubit, HomeCubitState>(
              builder: (context, state) {
                return loadList(context, state);
              },
            )
            // body: BlocBuilder<HomeCubit, HomeCubitState>(
            //   builder: (context, state) {
            //     return loadData(context, state);
            //   },
            // )
          );
        }
    );
  }

}

