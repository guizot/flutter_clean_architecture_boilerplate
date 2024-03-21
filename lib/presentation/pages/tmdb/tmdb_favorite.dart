import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/domain/entities/movie_tmdb.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_image/network.dart';
import '../../core/constant/routes_values.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import '../../core/utils/color_utils.dart';
import 'cubit/tmdb_cubit.dart';
import 'cubit/tmdb_state.dart';

class TMDBFavoriteWrapperProvider extends StatelessWidget {
  const TMDBFavoriteWrapperProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TMDBCubit>(),
      child: const TMDBFavoritePage(title: "TMDB Favorite"),
    );
  }
}

class TMDBFavoritePage extends StatefulWidget {
  const TMDBFavoritePage({super.key, required this.title});
  final String title;

  @override
  State<TMDBFavoritePage> createState() => _TMDBFavoritePageState();
}

class _TMDBFavoritePageState extends State<TMDBFavoritePage> {

  List<MovieTMDB>? movies;

  @override
  void initState() {
    getMovieLocal();
    super.initState();
  }

  /// REGION: LOCAL DATA SOURCE
  void getMovieLocal() async {
    List<MovieTMDB> movies = await BlocProvider.of<TMDBCubit>(context).getAllMovieLocal();
    setState(() {
      this.movies = movies;
    });
  }

  Widget loadList(BuildContext context, TMDBCubitState state) {
    if (state is TMDBInitial) {
      return Center(
          child: Container()
      );
    }
    else if (state is TMDBStateLoading) {
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
    else if (state is TMDBStateLoaded) {
      return ListView.builder(
          itemCount: movies != null ? movies!.length : 0 ,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {
                Navigator.pushNamed(
                    context,
                    RoutesValues.tmdbDetail,
                    arguments: movies![index].id
                ).then((value) {
                  getMovieLocal();
                });
              },
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
                backgroundImage: NetworkImage(movies![index].getPoster()),
              ),
            );
          }
        );
    }
    else if (state is TMDBStateEmpty) {
      return const Center(
          child: Text('Empty..')
      );
    }
    else if (state is TMDBStateError) {
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
            body: BlocBuilder<TMDBCubit, TMDBCubitState>(
              builder: (context, state) => loadList(context, state)
            )
          );
        }
    );
  }

}