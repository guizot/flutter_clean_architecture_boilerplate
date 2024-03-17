import 'package:flutter_clean_architecture/data/models/movie_detail.dart';
import '../../data/models/movie_response_wrapper.dart';
import '../../data/utils/resources/data_state.dart';

abstract class TMDBRepo {

  /// REGION: REMOTE DATA SOURCE
  Future<DataState<MovieResponseWrapper>> getMovieTrending(String time, Map<String, dynamic> movieQuery);
  Future<DataState<MovieDetail>> detailMovie(int movieId);

}