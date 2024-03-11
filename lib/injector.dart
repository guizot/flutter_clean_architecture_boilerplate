import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/data/datasources/shared_preferences_data_source.dart';
import 'package:flutter_clean_architecture/data/repositories/home_repo_impl.dart';
import 'package:flutter_clean_architecture/data/utils/const_values.dart';
import 'package:flutter_clean_architecture/domain/repositories/home_repo.dart';
import 'package:flutter_clean_architecture/domain/usecases/home_usecases.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_clean_architecture/presentation/core/services/theme_service.dart';
import 'package:flutter_clean_architecture/presentation/pages/home/cubit/home_cubit.dart';
import 'package:flutter_clean_architecture/presentation/pages/setting/cubit/setting_cubit.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/remote_data_source.dart';
import 'data/utils/interceptor/auth_interceptor.dart';

final sl = GetIt.I;

Future<void> init() async {

  /// PRESENTATION LAYER
  sl.registerFactory(
    () => HomeCubit(
      homeUseCases: sl()
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

  /// DATA LAYER
  sl.registerFactory<HomeRepo>(
    () => HomeRepoImpl(
      sharedPrefDataSources: sl(),
      remoteDataSources: sl()
    ),
  );
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSource(sl()),
  );

  /// MAIN INJECTOR & EXTERNAL LIBRARY
  sl.registerLazySingleton(() => SharedPreferenceDataSource());
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.interceptors.add(AuthInterceptor(sharedPreferenceDataSource: sl()));
    return dio;
  });

}