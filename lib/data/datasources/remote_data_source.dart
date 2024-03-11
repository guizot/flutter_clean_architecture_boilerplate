import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/data/models/response_wrapper.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/dio.dart';
import '../models/user.dart';
import '../utils/const_values.dart';
part 'remote_data_source.g.dart';

@RestApi(baseUrl: ConstValues.baseUrl)
abstract class RemoteDataSource {
  factory RemoteDataSource(Dio dio, {String baseUrl}) = _RemoteDataSource;

  @GET('search/users')
  Future<HttpResponse<ResponseWrapper<User>>> searchUser({
    @Queries() required Map<String, dynamic> queries
  });

}