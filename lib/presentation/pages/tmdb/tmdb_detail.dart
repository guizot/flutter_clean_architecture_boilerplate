import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/data/models/movie_detail.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import '../../../domain/entities/movie_tmdb.dart';
import '../../core/services/theme_service.dart';
import 'package:provider/provider.dart';
import '../../../injector.dart';
import '../../core/utils/color_utils.dart';
import '../../core/utils/platform_utils.dart';
import '../../core/utils/string_utils.dart';
import 'dart:io' show Platform;
import 'cubit/tmdb_cubit.dart';
import 'cubit/tmdb_state.dart';

class TMDBDetailWrapperProvider extends StatelessWidget {
  const TMDBDetailWrapperProvider({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TMDBCubit>(),
      child: TMDBDetailPage(title: "TMDB Detail", id: id),
    );
  }
}

class TMDBDetailPage extends StatefulWidget {
  const TMDBDetailPage({super.key, required this.title, required this.id});
  final String title;
  final int id;

  @override
  State<TMDBDetailPage> createState() => _TMDBDetailPageState();
}

class _TMDBDetailPageState extends State<TMDBDetailPage> {

  MovieDetail? detail;
  bool isFavorite = false;

  @override
  void initState() {
    getMovieDetail();
    super.initState();
  }

  /// REGION: REMOTE DATA SOURCE
  void getMovieDetail() async {
    MovieDetail? detail = await BlocProvider.of<TMDBCubit>(context).detailMovie(widget.id);
    if(detail != null) {
      getMovieLocal(detail.id!);
      setState(() {
        this.detail = detail;
      });
    }
  }

  /// REGION: LOCAL DATA SOURCE
  void getMovieLocal(int key) async {
    MovieTMDB? user = await BlocProvider.of<TMDBCubit>(context).getMovieLocal(key);
    if(user != null) {
      setState(() {
        isFavorite = true;
      });
    } else {
      setState(() {
        isFavorite = false;
      });
    }
  }

  void saveMovieLocal() async {
    if(detail != null) {
      await BlocProvider.of<TMDBCubit>(context).saveMovieLocal(detail!);
      getMovieLocal(detail!.id!);
    }
  }

  void deleteMovieLocal() async {
    if(detail != null) {
      await BlocProvider.of<TMDBCubit>(context).deleteMovieLocal(detail!.id!);
      getMovieLocal(detail!.id!);
    }
  }

  Widget getObjectDetail() {
    List<Widget> keys = [];
    if(detail != null) {
      detail!.toJson().forEach((final String key, final value) {
        keys.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "${StringUtils().convertToTitleCase(key)} :",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: ColorUtils().getMaterialColor(Theme.of(context).colorScheme.primary).shade800
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${value != "" ? value : "-"}",
                style: const TextStyle(
                    fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              const SizedBox(height: 10),
            ],
          )
        );
      });
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: keys
    );
  }

  SliverToBoxAdapter loadList(BuildContext context, TMDBCubitState state) {
    if (state is TMDBInitial) {
      return SliverToBoxAdapter(
          child: Container()
      );
    }
    else if (state is TMDBStateLoading) {
      return const SliverToBoxAdapter(
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
      return SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: getObjectDetail()
            )
        );
    }
    else if (state is TMDBStateError) {
      return SliverToBoxAdapter(
          child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                ),
              )
          )
      );
    }
    return SliverToBoxAdapter(
        child: Container()
    );
  }

  bool isCenterTitle() {
    if(PlatformUtils.isWeb) {
      return true;
    } else {
      if(Platform.isIOS) {
        return true;
      } else if(Platform.isAndroid) {
        return false;
      }
    }
    return false;
  }

  EdgeInsets? isTitlePadding() {
    if(PlatformUtils.isWeb) {
      return const EdgeInsets.symmetric(vertical: 16);
    } else {
      if(Platform.isIOS) {
        return const EdgeInsets.symmetric(vertical: 16);
      } else if(Platform.isAndroid) {
        return null;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeService, LanguageService> (
        builder: (context, ThemeService themeService, LanguageService languageService, child) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 500,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      detail?.title ?? "",
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white
                      )
                    ),
                    background: detail != null
                        ? Image.network(
                            detail!.getPoster(),
                            fit: BoxFit.cover,
                          )
                        : Container(),
                    centerTitle: isCenterTitle(),
                    titlePadding: isTitlePadding(),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_outline,
                          size: 26,
                          color: isFavorite ? Colors.red : null,
                        ),
                        tooltip: isFavorite ?  'Dislike' : 'Favorite',
                        onPressed: isFavorite ? deleteMovieLocal : saveMovieLocal,
                      ),
                    )
                  ],
                ),
                BlocBuilder<TMDBCubit, TMDBCubitState>(
                  builder: (context, state) {
                    return loadList(context, state);
                  },
                )
              ],
            )
          );
        }
    );
  }

}