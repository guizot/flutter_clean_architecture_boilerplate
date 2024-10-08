import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/data/core/interceptor/graphql_service.dart';
import 'package:flutter_clean_architecture/data/data_source/local/hive_data_source.dart';
import 'package:flutter_clean_architecture/data/data_source/local/sqlite_data_source.dart';
import 'package:flutter_clean_architecture/data/data_source/remote/firestore_data_source.dart';
import 'package:flutter_clean_architecture/data/data_source/remote/tmdb_data_source.dart';
import 'package:flutter_clean_architecture/data/data_source/shared/shared_preferences_data_source.dart';
import 'package:flutter_clean_architecture/data/repositories/firestore_repo_impl.dart';
import 'package:flutter_clean_architecture/data/repositories/github_repo_impl.dart';
import 'package:flutter_clean_architecture/data/repositories/home_repo_impl.dart';
import 'package:flutter_clean_architecture/data/core/interceptor/tmdb_interceptor.dart';
import 'package:flutter_clean_architecture/domain/repositories/firestore_repo.dart';
import 'package:flutter_clean_architecture/domain/repositories/github_repo.dart';
import 'package:flutter_clean_architecture/domain/repositories/graphql_repo.dart';
import 'package:flutter_clean_architecture/data/repositories/graphql_repo_impl.dart';
import 'package:flutter_clean_architecture/domain/repositories/home_repo.dart';
import 'package:flutter_clean_architecture/domain/repositories/tmdb_repo.dart';
import 'package:flutter_clean_architecture/domain/usecases/graphql_usecases.dart';
import 'package:flutter_clean_architecture/domain/usecases/home_usecases.dart';
import 'package:flutter_clean_architecture/domain/usecases/tmdb_usecases.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_clean_architecture/presentation/core/services/screen_size_service.dart';
import 'package:flutter_clean_architecture/presentation/core/services/theme_service.dart';
import 'package:flutter_clean_architecture/presentation/pages/github/cubit/github_cubit.dart';
import 'package:flutter_clean_architecture/presentation/pages/graphql/cubit/graphql_notes_cubit.dart';
import 'package:flutter_clean_architecture/presentation/pages/home/cubit/home_cubit.dart';
import 'package:flutter_clean_architecture/presentation/pages/notes/cubit/notes_cubit.dart';
import 'package:flutter_clean_architecture/presentation/pages/setting/cubit/setting_cubit.dart';
import 'package:flutter_clean_architecture/presentation/pages/tmdb/cubit/tmdb_cubit.dart';
import 'package:get_it/get_it.dart';
import 'data/data_source/remote/github_data_source.dart';
import 'data/data_source/remote/graphql_data_source.dart';
import 'data/repositories/tmdb_repo_impl.dart';
import 'data/core/interceptor/github_interceptor.dart';
import 'domain/usecases/firestore_usecases.dart';
import 'domain/usecases/github_usecases.dart';

final sl = GetIt.I;

Future<void> init() async {

  /// SERVICES
  sl.registerLazySingleton(
    () => ThemeService(
      sharedPreferenceDataSource: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => LanguageService(
      sharedPreferenceDataSource: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => ScreenSizeService(),
  );

  /// PRESENTATION LAYER
  sl.registerFactory(
    () => HomeCubit(
      homeUseCases: sl()
    ),
  );
  sl.registerFactory(
    () => GithubCubit(
      githubUseCases: sl()
    ),
  );
  sl.registerFactory(
    () => TMDBCubit(
      tmdbUseCases: sl()
    ),
  );
  sl.registerFactory(
    () => SettingCubit(
      sharedPreferenceDataSource: sl()
    ),
  );
  sl.registerFactory(
    () => NotesCubit(
      fireStoreUseCases: sl()
    ),
  );
  sl.registerFactory(
    () => GraphQLNotesCubit(
      graphQLUseCases: sl()
    ),
  );

  /// DOMAIN LAYER
  sl.registerLazySingleton(
    () => HomeUseCases(
      homeRepo: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GithubUseCases(
      githubRepo: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => TMDBUseCases(
      tmdbRepo: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => FireStoreUseCases(
      fireStoreRepo: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GraphQLUseCases(
      graphQLRepo: sl(),
    ),
  );

  /// DATA LAYER
  sl.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(
      sharedPrefDataSources: sl(),
      githubDataSource: sl(),
      tmdbDataSource: sl()
    ),
  );
  sl.registerLazySingleton<GithubRepo>(
    () => GithubRepoImpl(
      githubDataSource: sl(),
      hiveDataSource: sl()
    ),
  );
  sl.registerLazySingleton<TMDBRepo>(
    () => TMDBRepoImpl(
      tmdbDataSource: sl(),
      sqliteDataSource: sl()
    ),
  );
  sl.registerLazySingleton<FireStoreRepo>(
    () => FireStoreRepoImpl(
      fireStoreDataSource: sl()
    ),
  );
  sl.registerLazySingleton<GraphQLRepo>(
    () => GraphQLRepoImpl(
      graphQLDataSource: sl(),
      sharedPreferenceDataSource: sl()
    ),
  );

  /// DATA SOURCES
  sl.registerLazySingleton<GithubDataSource>(
    () {
      final dio = Dio();
      dio.interceptors.add(GithubInterceptor(sharedPreferenceDataSource: sl()));
      return GithubDataSource(dio);
    },
  );
  sl.registerLazySingleton<TMDBDataSource>(
    () {
      final dio = Dio();
      dio.interceptors.add(TMDBInterceptor());
      return TMDBDataSource(dio);
    },
  );
  sl.registerLazySingleton<FireStoreDataSource>(
    () {
      return FireStoreDataSource(FirebaseFirestore.instance);
    },
  );
  sl.registerLazySingleton<GraphQLDataSource>(
    () {
      return GraphQLDataSource(
        GraphQLService(sharedPreferenceDataSource: sl()).instance
      );
    },
  );

  /// MAIN INJECTOR & EXTERNAL LIBRARY
  sl.registerLazySingleton(() => SharedPreferenceDataSource());
  sl.registerLazySingleton(() => HiveDataSource());
  sl.registerLazySingleton(() => SqliteDataSource());
  // sl.registerFactory<Dio>(() {
  //   final dio = Dio();
    // dio.interceptors.add(PrettyDioLogger(
    //     requestHeader: true,
    //     requestBody: true,
    //     responseBody: true,
    //     responseHeader: false,
    //     error: true,
    //     compact: true,
    //     maxWidth: 90));
  //   return dio;
  // });

}