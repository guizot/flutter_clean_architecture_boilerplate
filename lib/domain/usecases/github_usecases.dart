import '../../data/models/response_wrapper.dart';
import '../../data/models/user.dart';
import '../../data/utils/resources/data_state.dart';
import '../repositories/github_repo.dart';

class GithubUseCases {

  /// REGION: INIT USE CASE
  final GithubRepo githubRepo;
  GithubUseCases({required this.githubRepo});

  /// REGION: REMOTE DATA SOURCE
  Future<DataState<ResponseWrapper<User>>> searchUser(String username) async {
    return githubRepo.searchUser(username);
  }

}