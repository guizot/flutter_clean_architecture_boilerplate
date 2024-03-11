import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/user.dart';
import '../../../../domain/usecases/home_usecases.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeCubitState> {

  /// REGION: INIT CUBIT
  final HomeUseCases homeUseCases;
  HomeCubit({required this.homeUseCases}) : super(HomeInitial());

  /// REGION: LOCAL DATA SOURCE
  void getData() async {
    emit(HomeStateLoading());
    Future.delayed(const Duration(seconds: 5)).then((value) => emit(HomeStateLoaded()));
  }

  Future<List<User>?> searchUser(String username) async {
    emit(HomeStateLoading());
    final users = await homeUseCases.searchUser(username);
    //print("users.data: ${users.data}");
    //print("users.error: ${users.error}");
    emit(HomeStateLoaded());
    return users.data?.items;
  }

}