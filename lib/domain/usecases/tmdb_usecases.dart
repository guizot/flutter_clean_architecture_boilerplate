import 'package:flutter_clean_architecture/data/models/movie_detail.dart';
import '../../data/models/movie_response_wrapper.dart';
import '../../data/utils/resources/data_state.dart';
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

}