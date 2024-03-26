import 'package:flutter_clean_architecture/data/models/movie_detail.dart';
import 'package:flutter_clean_architecture/domain/entities/movie_tmdb.dart';
import '../../data/models/movie_response_wrapper.dart';
import '../../data/core/resources/data_state.dart';
import '../repositories/tmdb_repo.dart';

class TMDBUseCases {

  /// REGION: INIT USE CASE
  final TMDBRepo tmdbRepo;
  TMDBUseCases({required this.tmdbRepo});

  /// REGION: REMOTE DATA SOURCE
  Future<DataState<MovieResponseWrapper>> getMovieTrending(String time, Map<String, dynamic> movieQuery) async {
    return tmdbRepo.getMovieTrending(time, movieQuery);
  }

  Future<DataState<MovieDetail>> detailMovie(int movieId) async {
    // space for business logic (before return / before send)
    return tmdbRepo.detailMovie(movieId);
  }

  /// REGION: LOCAL DATA SOURCE
  Future<List<MovieTMDB>> getAllMovieLocal() {
    // space for business logic (before return / before send)
    return tmdbRepo.getAllMovieLocal();
  }

  Future<MovieTMDB?> getMovieLocal(int key) {
    // space for business logic (before return / before send)
    return tmdbRepo.getMovieLocal(key);
  }

  Future<void> saveMovieLocal(MovieDetail detail) async {
    MovieTMDB movie = MovieTMDB(
      id: detail.id,
      title: detail.title,
      overview: detail.overview,
      posterPath: detail.posterPath,
    );
    return tmdbRepo.saveMovieLocal(movie);
  }

  Future<void> deleteMovieLocal(int key) async {
    // space for business logic (before return / before send)
    return tmdbRepo.deleteMovieLocal(key);
  }

}