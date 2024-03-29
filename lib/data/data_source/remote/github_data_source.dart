import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/data/models/user_response_wrapper.dart';
import 'package:flutter_clean_architecture/data/models/user_detail.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/dio.dart';
import '../../models/user.dart';
import '../../core/constant/const_values.dart';
part 'github_data_source.g.dart';

@RestApi(baseUrl: ConstValues.githubBaseUrl)
abstract class GithubDataSource {
  factory GithubDataSource(Dio dio, {String baseUrl}) = _GithubDataSource;

  @GET('search/users')
  Future<HttpResponse<UserResponseWrapper<User>>> searchUser({
    @Queries() required Map<String, dynamic> queries
  });

  @GET('users/{username}')
  Future<HttpResponse<UserDetail>> detailUser({
    @Path() required String username
  });

}