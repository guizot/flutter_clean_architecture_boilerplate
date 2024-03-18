import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/data/models/movie_detail.dart';
import 'package:flutter_clean_architecture/domain/entities/movie_tmdb.dart';
import 'package:flutter_clean_architecture/domain/entities/movie_tmdb.dart';
import 'package:flutter_clean_architecture/domain/entities/movie_tmdb.dart';
import 'package:flutter_clean_architecture/presentation/pages/tmdb/cubit/tmdb_state.dart';
import '../../../../data/models/movie.dart';
import '../../../../domain/usecases/tmdb_usecases.dart';

class TMDBCubit extends Cubit<TMDBCubitState> {

  /// REGION: INIT CUBIT
  final TMDBUseCases tmdbUseCases;
  TMDBCubit({required this.tmdbUseCases}) : super(TMDBInitial());

  /// REGION: REMOTE DATA SOURCE
  Future<List<Movie>> getMovieTrending(String time, Map<String, dynamic> movieQuery) async {
    final results = await tmdbUseCases.getMovieTrending(time, movieQuery);
    if(results.data != null) {
      return results.data != null ? results.data!.results! : List.empty();
    }
    if(results.error != null) {
      throw Exception(results.error.toString());
    }
    return List.empty();
  }

  Future<MovieDetail?> detailMovie(int movieId) async {
    emit(TMDBStateLoading());
    final users = await tmdbUseCases.detailMovie(movieId);
    if(users.data != null) {
      emit(TMDBStateLoaded());
      return users.data;
    }
    if(users.error != null) {
      emit(TMDBStateError(message: users.error.toString()));
    }
    return null;
  }

  /// REGION: LOCAL DATA SOURCE
  Future<List<MovieTMDB>> getAllMovieLocal() async {
    emit(TMDBStateLoading());
    List<MovieTMDB> users = await tmdbUseCases.getAllMovieLocal();
    if(users.isEmpty) {
      emit(TMDBStateEmpty());
    } else if(users.isNotEmpty) {
      emit(TMDBStateLoaded());
    }
    return users;
  }

  Future<MovieTMDB?> getMovieLocal(int key) async {
    return await tmdbUseCases.getMovieLocal(key);
  }

  Future<void> saveMovieLocal(MovieDetail detail) async {
    await tmdbUseCases.saveMovieLocal(detail);
  }

  Future<void> deleteMovieLocal(int key) async {
    await tmdbUseCases.deleteMovieLocal(key);
  }

}