import 'package:flutter_clean_architecture/data/models/user_detail.dart';
import 'package:flutter_clean_architecture/domain/entities/user_github.dart';
import '../../data/models/user_response_wrapper.dart';
import '../../data/models/user.dart';
import '../../data/utils/resources/data_state.dart';

abstract class GithubRepo {

  /// REGION: REMOTE DATA SOURCE
  Future<DataState<UserResponseWrapper<User>>> searchUser(Map<String, dynamic> userQuery);
  Future<DataState<UserDetail>> detailUser(String username);

  /// REGION: LOCAL DATA SOURCE
  List<UserGithub> getAllUserLocal();
  UserGithub? getUserLocal(int key);
  Future<void> saveUserLocal(int key, UserGithub user);
  Future<void> deleteUserLocal(int key);

}