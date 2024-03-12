import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/movie.dart';
import '../../../../data/models/user.dart';
import '../../../../domain/usecases/home_usecases.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeCubitState> {

  /// REGION: INIT CUBIT
  final HomeUseCases homeUseCases;
  HomeCubit({required this.homeUseCases}) : super(HomeInitial());

  void getData() async {
    emit(HomeStateLoading());
    Future.delayed(const Duration(seconds: 5)).then((value) => emit(HomeStateLoaded()));
  }

  Future<List<User>?> searchUser(String username) async {
    emit(HomeStateLoading());
    final users = await homeUseCases.searchUser(username);
    if(users.data != null) {
      // print("users.data: ${users.data}");
      emit(HomeStateLoaded());
      return users.data?.items;
    }
    emit(HomeStateError(message: users.error!.toString()));
    return null;
  }

  Future<List<Movie>?> getMovieTrending(String time) async {
    emit(HomeStateLoading());
    final results = await homeUseCases.getMovieTrending(time);
    if(results.data != null) {
      // print("users.data: ${results.data}");
      emit(HomeStateLoaded());
      return results.data?.results;
    }
    emit(HomeStateError(message: results.error!.toString()));
    return null;
  }

}