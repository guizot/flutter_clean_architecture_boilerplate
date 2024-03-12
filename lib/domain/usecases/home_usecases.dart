import 'package:flutter_clean_architecture/data/models/movie_trending_wrapper.dart';

import '../../data/models/response_wrapper.dart';
import '../../data/models/user.dart';
import '../../data/utils/resources/data_state.dart';
import '../repositories/home_repo.dart';

class HomeUseCases {

  /// REGION: INIT USE CASE
  final HomeRepo homeRepo;
  HomeUseCases({required this.homeRepo});

  /// REGION: REMOTE DATA SOURCE
  Future<DataState<ResponseWrapper<User>>> searchUser(String username) async {
    return homeRepo.searchUser(username);
  }

  Future<DataState<MovieTrendingWrapper>> getMovieTrending(String time) async {
    return homeRepo.getMovieTrending(time);
  }

}