import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/data/data_source/local/hive_data_source.dart';
import 'package:flutter_clean_architecture/data/data_source/local/sqlite_data_source.dart';
import 'package:flutter_clean_architecture/data/data_source/remote/tmdb_data_source.dart';
import 'package:flutter_clean_architecture/data/models/movie_detail.dart';
import 'package:flutter_clean_architecture/domain/entities/movie_tmdb.dart';
import 'package:sqflite/sqflite.dart';
import '../../domain/repositories/tmdb_repo.dart';
import '../models/movie_response_wrapper.dart';
import '../utils/constant/const_values.dart';
import '../utils/resources/data_state.dart';

class TMDBRepoImpl implements TMDBRepo {

  /// REGION: INIT IMPLEMENTOR
  final TMDBDataSource tmdbDataSource;
  final SqliteDataSource sqliteDataSource;

  TMDBRepoImpl({
    required this.tmdbDataSource,
    required this.sqliteDataSource,
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

  /// REGION: LOCAL DATA SOURCE
  @override
  Future<List<MovieTMDB>> getAllMovieLocal() async {
    final db = await sqliteDataSource.database;
    final List<Map<String, dynamic>> movies = await db.query(ConstValues.moviesTable);
    return [
      for (
        final {
          'id': id as int,
          'title': title as String,
          'overview': overview as String,
          'poster_path': posterPath as String,
        } in movies
      )
      MovieTMDB(id: id, title: title, overview: overview, posterPath: posterPath)
    ];
  }

  @override
  Future<MovieTMDB?> getMovieLocal(int key) async{
    final db = await sqliteDataSource.database;
    List<Map<String, dynamic>> result = await db.query(
      ConstValues.moviesTable,
      where: 'id = ?',
      whereArgs: [key],
    );
    if(result.isNotEmpty) {
      Map<String, dynamic> movie = result.first;
      return MovieTMDB(
          id: movie['id'],
          title: movie['title'],
          overview: movie['overview'],
          posterPath: movie['poster_path']
      );
    } else {
      return null;
    }
  }

  @override
  Future<void> saveMovieLocal(MovieTMDB movie) async {
    final db = await sqliteDataSource.database;
    await db.insert(
      ConstValues.moviesTable,
      movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteMovieLocal(int key) async {
    final db = await sqliteDataSource.database;
    await db.delete(
      ConstValues.moviesTable,
      where: 'id = ?',
      whereArgs: [key],
    );
  }

}