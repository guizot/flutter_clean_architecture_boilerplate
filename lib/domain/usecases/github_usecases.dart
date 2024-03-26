import 'package:flutter_clean_architecture/data/models/user_detail.dart';
import 'package:flutter_clean_architecture/domain/entities/user_github.dart';
import '../../data/models/user_response_wrapper.dart';
import '../../data/models/user.dart';
import '../../data/core/resources/data_state.dart';
import '../repositories/github_repo.dart';

class GithubUseCases {

  /// REGION: INIT USE CASE
  final GithubRepo githubRepo;
  GithubUseCases({required this.githubRepo});

  /// REGION: REMOTE DATA SOURCE
  Future<DataState<UserResponseWrapper<User>>> searchUser(Map<String, dynamic> userQuery) async {
    // space for business logic (before return / before send)
    return githubRepo.searchUser(userQuery);
  }

  Future<DataState<UserDetail>> detailUser(String username) async {
    // space for business logic (before return / before send)
    return githubRepo.detailUser(username);
  }

  /// REGION: LOCAL DATA SOURCE
  List<UserGithub> getAllUserLocal() {
    // space for business logic (before return / before send)
    return githubRepo.getAllUserLocal();
  }

  UserGithub? getUserLocal(int key) {
    // space for business logic (before return / before send)
    return githubRepo.getUserLocal(key);
  }

  Future<void> saveUserLocal(UserDetail detail) async {
    UserGithub user = UserGithub(
      id: detail.id,
      login: detail.login,
      avatarUrl: detail.avatarUrl,
      htmlUrl: detail.htmlUrl,
    );
    return githubRepo.saveUserLocal(detail.id ?? 0, user);
  }

  Future<void> deleteUserLocal(int key) async {
    // space for business logic (before return / before send)
    return githubRepo.deleteUserLocal(key);
  }

}