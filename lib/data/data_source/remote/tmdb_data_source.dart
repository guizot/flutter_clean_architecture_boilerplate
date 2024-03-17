import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/data/models/movie_response_wrapper.dart';
import 'package:flutter_clean_architecture/data/models/user_response_wrapper.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/dio.dart';
import '../../models/user.dart';
import '../../utils/const_values.dart';
part 'tmdb_data_source.g.dart';

@RestApi(baseUrl: ConstValues.tmdbBaseUrl)
abstract class TMDBDataSource {
  factory TMDBDataSource(Dio dio, {String baseUrl}) = _TMDBDataSource;

  @GET('trending/movie/{time}')
  Future<HttpResponse<MovieResponseWrapper>> getTrendingMovie({
    @Path("time") String time = "day"
  });

}