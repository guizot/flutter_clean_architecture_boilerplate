import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/data/data_source/remote/tmdb_data_source.dart';
import 'package:flutter_clean_architecture/data/data_source/shared/shared_preferences_data_source.dart';
import 'package:flutter_clean_architecture/data/models/movie_response_wrapper.dart';
import '../../domain/repositories/home_repo.dart';
import '../data_source/remote/github_data_source.dart';
import '../models/user_response_wrapper.dart';
import '../models/user.dart';
import '../utils/resources/data_state.dart';

class HomeRepoImpl implements HomeRepo {

  /// REGION: INIT IMPLEMENTOR
  final SharedPreferenceDataSource sharedPrefDataSources;
  final GithubDataSource githubDataSource;
  final TMDBDataSource tmdbDataSource;

  HomeRepoImpl({
    required this.sharedPrefDataSources,
    required this.githubDataSource,
    required this.tmdbDataSource,
  });

  /// REGION: REMOTE DATA SOURCE
  @override
  Future<DataState<UserResponseWrapper<User>>> searchUser(String username) async {
    try {
      var queryUser = 'followers:>10000';
      if(username.isNotEmpty) { queryUser = username; }
      Map<String, dynamic> userQuery = {
        'q': queryUser,
        'per_page': 10,
        'page': 1
      };
      final httpResponse = await githubDataSource.searchUser(queries: userQuery);
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      }
      return DataError(DioException(
        error: httpResponse.response.statusMessage,
        response: httpResponse.response,
        requestOptions: httpResponse.response.requestOptions,
        type: DioExceptionType.badResponse,
      ));
    } on DioException catch (e) {
      return DataError(e);
    }
  }

  @override
  Future<DataState<MovieResponseWrapper>> getMovieTrending(String time, Map<String, dynamic> movieQuery) async {
    try {
      final httpResponse = await tmdbDataSource.getTrendingMovie(time: time, queries: movieQuery);
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      }
      return DataError(DioException(
        error: httpResponse.response.statusMessage,
        response: httpResponse.response,
        requestOptions: httpResponse.response.requestOptions,
        type: DioExceptionType.badResponse,
      ));
    } on DioException catch (e) {
      return DataError(e);
    }
  }


}