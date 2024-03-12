import 'package:flutter_clean_architecture/data/models/movie_trending_wrapper.dart';
import '../../data/models/response_wrapper.dart';
import '../../data/models/user.dart';
import '../../data/utils/resources/data_state.dart';

abstract class HomeRepo {

  /// REGION: REMOTE DATA SOURCE
  Future<DataState<ResponseWrapper<User>>> searchUser(String username);
  Future<DataState<MovieTrendingWrapper>> getMovieTrending(String time);

}