import '../../data/models/response_wrapper.dart';
import '../../data/models/user.dart';
import '../../data/utils/resources/data_state.dart';
import '../repositories/home_repo.dart';

class HomeUseCases {

  /// REGION: INIT USE CASE
  final HomeRepo homeRepo;
  HomeUseCases({required this.homeRepo});

  /// REGION: REMOTE DATA SOURCE
  Future<DataState<ResponseWrapper<User>>> searchUser(String username) async {
    return homeRepo.searchUser(username);
  }

}