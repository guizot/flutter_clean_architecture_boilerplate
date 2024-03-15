import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/data/data_source/shared_preferences_data_source.dart';
import 'package:flutter_clean_architecture/data/models/user_detail.dart';
import 'package:flutter_clean_architecture/domain/repositories/github_repo.dart';
import '../data_source/remote/github_data_source.dart';
import '../models/response_wrapper.dart';
import '../models/user.dart';
import '../utils/resources/data_state.dart';

class GithubRepoImpl implements GithubRepo {

  /// REGION: INIT IMPLEMENTOR
  final SharedPreferenceDataSource sharedPrefDataSources;
  final GithubDataSource githubDataSource;

  GithubRepoImpl({
    required this.sharedPrefDataSources,
    required this.githubDataSource,
  });

  /// REGION: REMOTE DATA SOURCE
  @override
  Future<DataState<ResponseWrapper<User>>> searchUser(Map<String, dynamic> userQuery) async {
    try {
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
  Future<DataState<UserDetail>> detailUser(String username) async {
    try {
      final httpResponse = await githubDataSource.detailUser(username: username);
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