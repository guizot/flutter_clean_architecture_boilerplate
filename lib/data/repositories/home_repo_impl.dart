import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/data/datasources/shared_preferences_data_source.dart';
import '../../domain/repositories/home_repo.dart';
import '../datasources/remote_data_source.dart';
import '../models/response_wrapper.dart';
import '../models/user.dart';
import '../utils/resources/data_state.dart';

class HomeRepoImpl implements HomeRepo {

  /// REGION: INIT IMPLEMENTOR
  final SharedPreferenceDataSource sharedPrefDataSources;
  final RemoteDataSource remoteDataSources;

  HomeRepoImpl({
    required this.sharedPrefDataSources,
    required this.remoteDataSources,
  });

  /// REGION: REMOTE DATA SOURCE
  @override
  Future<DataState<ResponseWrapper<User>>> searchUser(String username) async {

    try {
      Map<String, dynamic> userQuery = {
        'q': 'followers:>10000',
        'per_page': 10,
        'page': 1
      };
      final httpResponse = await remoteDataSources.searchUser(queries: userQuery);
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      }
      return DataError(DioError(
        error: httpResponse.response.statusMessage,
        response: httpResponse.response,
        requestOptions: httpResponse.response.requestOptions,
        type: DioErrorType.badResponse,
      ));
    } on DioError catch (e) {
      return DataError(e);
    }

  }


}