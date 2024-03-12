import 'package:dio/dio.dart';
import '../const_values.dart';
import 'package:flutter_clean_architecture/data/data_source/shared_preferences_data_source.dart';

class TMDBInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.receiveTimeout = const Duration(seconds: 10);
    options.connectTimeout = const Duration(seconds: 10);
    options.contentType = 'application/json';
    options.headers['Authorization'] = 'Bearer ${ConstValues.tmdbToken}';
      return super.onRequest(options, handler);
  }

}