import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/data/data_source/local/hive_data_source.dart';
import 'package:flutter_clean_architecture/data/data_source/remote/tmdb_data_source.dart';
import 'package:flutter_clean_architecture/data/models/movie_detail.dart';
import '../../domain/repositories/tmdb_repo.dart';
import '../models/movie_response_wrapper.dart';
import '../utils/resources/data_state.dart';

class TMDBRepoImpl implements TMDBRepo {

  /// REGION: INIT IMPLEMENTOR
  final TMDBDataSource tmdbDataSource;
  final HiveDataSource hiveDataSource;

  TMDBRepoImpl({
    required this.tmdbDataSource,
    required this.hiveDataSource,
  });

  /// REGION: REMOTE DATA SOURCE


  @override
  Future<DataState<MovieResponseWrapper>> getMovieTrending(String time, Map<String, dynamic> movieQuery) async {
    try {
      final httpResponse = await tmdbDataSource.getTrendingMovie(time: time, queries: movieQuery);
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      }
      return DataError(DioException(
        error: httpResponse.response.statusMessage,
        response: httpResponse.response,
        requestOptions: httpResponse.response.requestOptions,
        type: DioExceptionType.badResponse,
      ));
    } on DioException catch (e) {
      return DataError(e);
    }
  }

  @override
  Future<DataState<MovieDetail>> detailMovie(int movieId) async {
    try {
      final httpResponse = await tmdbDataSource.detailMovie(movieId: movieId);
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      }
      return DataError(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions,
            type: DioExceptionType.badResponse,
          )
      );
    } on DioException catch (e) {
      return DataError(e);
    }
  }

}