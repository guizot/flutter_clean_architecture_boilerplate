import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/data/data_source/local/hive_data_source.dart';
import 'package:flutter_clean_architecture/data/data_source/remote/tmdb_data_source.dart';
import 'package:flutter_clean_architecture/data/data_source/shared/shared_preferences_data_source.dart';
import 'package:flutter_clean_architecture/data/repositories/github_repo_impl.dart';
import 'package:flutter_clean_architecture/data/repositories/home_repo_impl.dart';
import 'package:flutter_clean_architecture/data/utils/interceptor/tmdb_interceptor.dart';
import 'package:flutter_clean_architecture/domain/repositories/github_repo.dart';
import 'package:flutter_clean_architecture/domain/repositories/home_repo.dart';
import 'package:flutter_clean_architecture/domain/usecases/home_usecases.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_clean_architecture/presentation/core/services/theme_service.dart';
import 'package:flutter_clean_architecture/presentation/pages/github/cubit/github_cubit.dart';
import 'package:flutter_clean_architecture/presentation/pages/home/cubit/home_cubit.dart';
import 'package:flutter_clean_architecture/presentation/pages/setting/cubit/setting_cubit.dart';
import 'package:get_it/get_it.dart';
import 'data/data_source/remote/github_data_source.dart';
import 'data/utils/interceptor/github_interceptor.dart';
import 'domain/usecases/github_usecases.dart';

final sl = GetIt.I;

Future<void> init() async {

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
    () => SettingCubit(
      sharedPreferenceDataSource: sl()
    ),
  );
  sl.registerFactory(
    () => ThemeService(
      sharedPreferenceDataSource: sl(),
    ),
  );
  sl.registerFactory(
        () => LanguageService(
      sharedPreferenceDataSource: sl(),
    ),
  );

  /// DOMAIN LAYER
  sl.registerFactory(
    () => HomeUseCases(
      homeRepo: sl(),
    ),
  );
  sl.registerFactory(
    () => GithubUseCases(
      githubRepo: sl(),
    ),
  );

  /// DATA LAYER
  sl.registerFactory<HomeRepo>(
    () => HomeRepoImpl(
      sharedPrefDataSources: sl(),
      githubDataSource: sl(),
      tmdbDataSource: sl()
    ),
  );
  sl.registerFactory<GithubRepo>(
    () => GithubRepoImpl(
      sharedPrefDataSources: sl(),
      githubDataSource: sl(),
      hiveDataSource: sl()
    ),
  );
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

  /// MAIN INJECTOR & EXTERNAL LIBRARY
  sl.registerFactory(() => SharedPreferenceDataSource());
  sl.registerFactory(() => HiveDataSource());
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