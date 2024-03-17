import 'package:dio/dio.dart';
import '../const_values.dart';
import 'package:flutter_clean_architecture/data/data_source/shared/shared_preferences_data_source.dart';

class GithubInterceptor extends Interceptor {

  final SharedPreferenceDataSource sharedPreferenceDataSource;
  GithubInterceptor({required this.sharedPreferenceDataSource});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // final token = await sharedPreferenceDataSource.getString(ConstValues.token);
    options.receiveTimeout = const Duration(seconds: 10);
    options.connectTimeout = const Duration(seconds: 10);
    options.contentType = 'application/json';
    options.headers['Authorization'] = ConstValues.githubToken;
      return super.onRequest(options, handler);
  }

}