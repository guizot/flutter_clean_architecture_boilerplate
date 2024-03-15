import 'package:flutter_clean_architecture/data/models/user_detail.dart';

import '../../data/models/response_wrapper.dart';
import '../../data/models/user.dart';
import '../../data/utils/resources/data_state.dart';
import '../repositories/github_repo.dart';

class GithubUseCases {

  /// REGION: INIT USE CASE
  final GithubRepo githubRepo;
  GithubUseCases({required this.githubRepo});

  /// REGION: REMOTE DATA SOURCE
  Future<DataState<ResponseWrapper<User>>> searchUser(Map<String, dynamic> userQuery) async {
    return githubRepo.searchUser(userQuery);
  }

  Future<DataState<UserDetail>> detailUser(String username) async {
    return githubRepo.detailUser(username);
  }

}