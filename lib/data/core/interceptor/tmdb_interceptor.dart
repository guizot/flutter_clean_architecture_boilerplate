import 'package:dio/dio.dart';
import '../constant/const_values.dart';

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