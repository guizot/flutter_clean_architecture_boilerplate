import 'package:flutter_clean_architecture/data/models/movie_detail.dart';
import 'package:flutter_clean_architecture/domain/entities/movie_tmdb.dart';
import '../../data/models/movie_response_wrapper.dart';
import '../../data/core/resources/data_state.dart';

abstract class TMDBRepo {

  /// REGION: REMOTE DATA SOURCE
  Future<DataState<MovieResponseWrapper>> getMovieTrending(String time, Map<String, dynamic> movieQuery);
  Future<DataState<MovieDetail>> detailMovie(int movieId);

  /// REGION: LOCAL DATA SOURCE
  Future<List<MovieTMDB>> getAllMovieLocal();
  Future<MovieTMDB?> getMovieLocal(int key);
  Future<void> saveMovieLocal(MovieTMDB movie);
  Future<void> deleteMovieLocal(int key);

}