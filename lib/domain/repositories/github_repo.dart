import 'package:flutter_clean_architecture/data/models/movie_trending_wrapper.dart';
import 'package:flutter_clean_architecture/data/models/user_detail.dart';
import '../../data/models/response_wrapper.dart';
import '../../data/models/user.dart';
import '../../data/utils/resources/data_state.dart';

abstract class GithubRepo {

  /// REGION: REMOTE DATA SOURCE
  Future<DataState<ResponseWrapper<User>>> searchUser(Map<String, dynamic> userQuery);
  Future<DataState<UserDetail>> detailUser(String username);

}