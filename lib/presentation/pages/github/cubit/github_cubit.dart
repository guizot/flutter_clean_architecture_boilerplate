import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/data/models/user_detail.dart';
import '../../../../data/models/user.dart';
import '../../../../domain/usecases/github_usecases.dart';
import 'github_state.dart';

class GithubCubit extends Cubit<GithubCubitState> {

  /// REGION: INIT CUBIT
  final GithubUseCases githubUseCases;
  GithubCubit({required this.githubUseCases}) : super(GithubInitial());

  void getData() async {
    emit(GithubStateLoading());
    Future.delayed(const Duration(seconds: 5)).then((value) => emit(GithubStateLoaded()));
  }

  Future<List<User>?> searchUser(String username) async {
    emit(GithubStateLoading());
    final users = await githubUseCases.searchUser(username);
    if(users.data != null) {
      emit(GithubStateLoaded());
      return users.data?.items;
    }
    emit(GithubStateError(message: users.error!.toString()));
    return null;
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