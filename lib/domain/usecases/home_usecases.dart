import 'package:flutter_clean_architecture/data/models/movie_response_wrapper.dart';
import '../../data/models/user_response_wrapper.dart';
import '../../data/models/user.dart';
import '../../data/utils/resources/data_state.dart';
import '../repositories/home_repo.dart';

class HomeUseCases {

  /// REGION: INIT USE CASE
  final HomeRepo homeRepo;
  HomeUseCases({required this.homeRepo});

  /// REGION: REMOTE DATA SOURCE
  Future<DataState<UserResponseWrapper<User>>> searchUser(String username) async {
    return homeRepo.searchUser(username);
  }

  Future<DataState<MovieResponseWrapper>> getMovieTrending(String time) async {
    return homeRepo.getMovieTrending(time);
  }

}