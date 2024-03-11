import 'package:dio/dio.dart';
import '../const_values.dart';
import 'package:flutter_clean_architecture/data/datasources/shared_preferences_data_source.dart';

class AuthInterceptor extends Interceptor {

  final SharedPreferenceDataSource sharedPreferenceDataSource;
  AuthInterceptor({required this.sharedPreferenceDataSource});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await sharedPreferenceDataSource.getString(ConstValues.token);
    options.receiveTimeout = const Duration(seconds: 10);
    options.connectTimeout = const Duration(seconds: 10);
    options.contentType = 'application/json';
    options.headers['Authorization'] = 'Bearer ${ConstValues.githubToken}';
      return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }

}