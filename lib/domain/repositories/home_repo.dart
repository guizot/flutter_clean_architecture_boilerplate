import 'package:flutter_clean_architecture/data/models/movie_response_wrapper.dart';
import '../../data/models/user_response_wrapper.dart';
import '../../data/models/user.dart';
import '../../data/core/resources/data_state.dart';

abstract class HomeRepo {

  /// REGION: REMOTE DATA SOURCE
  Future<DataState<UserResponseWrapper<User>>> searchUser(String username);
  Future<DataState<MovieResponseWrapper>> getMovieTrending(String time, Map<String, dynamic> movieQuery);

}