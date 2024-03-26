import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/data/data_source/local/hive_data_source.dart';
import 'package:flutter_clean_architecture/data/models/user_detail.dart';
import 'package:flutter_clean_architecture/domain/entities/user_github.dart';
import 'package:flutter_clean_architecture/domain/repositories/github_repo.dart';
import '../data_source/remote/github_data_source.dart';
import '../models/user_response_wrapper.dart';
import '../models/user.dart';
import '../core/resources/data_state.dart';

class GithubRepoImpl implements GithubRepo {

  /// REGION: INIT IMPLEMENTOR
  final GithubDataSource githubDataSource;
  final HiveDataSource hiveDataSource;

  GithubRepoImpl({
    required this.githubDataSource,
    required this.hiveDataSource,
  });

  /// REGION: REMOTE DATA SOURCE
  @override
  Future<DataState<UserResponseWrapper<User>>> searchUser(Map<String, dynamic> userQuery) async {
    try {
      final httpResponse = await githubDataSource.searchUser(queries: userQuery);
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      }
      return DataError(
        DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioExceptionType.badResponse,
        )
      );
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
      return DataError(
        DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
          type: DioExceptionType.badResponse,
        )
      );
    } on DioException catch (e) {
      return DataError(e);
    }
  }

  /// REGION: LOCAL DATA SOURCE
  @override
  List<UserGithub> getAllUserLocal() {
    return hiveDataSource.userGithubBox.values.toList();
  }

  @override
  UserGithub? getUserLocal(int key) {
    return hiveDataSource.userGithubBox.get(key);
  }

  @override
  Future<void> saveUserLocal(int key, UserGithub user) async {
    await hiveDataSource.userGithubBox.put(key, user);
  }

  @override
  Future<void> deleteUserLocal(int key) async {
    await hiveDataSource.userGithubBox.delete(key);
  }

}