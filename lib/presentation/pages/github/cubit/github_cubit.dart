import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/data/models/user_detail.dart';
import '../../../../data/models/user.dart';
import '../../../../domain/usecases/github_usecases.dart';
import 'github_state.dart';

class GithubCubit extends Cubit<GithubCubitState> {

  /// REGION: INIT CUBIT
  final GithubUseCases githubUseCases;
  GithubCubit({required this.githubUseCases}) : super(GithubInitial());

  Future<List<User>> searchUser(Map<String, dynamic> userQuery) async {
    final users = await githubUseCases.searchUser(userQuery);
    if(users.data != null) {
      return users.data != null ? users.data!.items! : List.empty();
    }
    if(users.error != null) {
      throw Exception('${users.error}');
    }
    return List.empty();
  }

  Future<UserDetail?> detailUser(String username) async {
    emit(GithubStateLoading());
    final users = await githubUseCases.detailUser(username);
    if(users.data != null) {
      emit(GithubStateLoaded());
      return users.data;
    }
    emit(GithubStateError(message: users.error!.toString()));
    return null;
  }

}