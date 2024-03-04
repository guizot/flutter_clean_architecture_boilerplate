import 'package:flutter_clean_architecture/data/datasources/shared_preferences_data_source.dart';
import 'package:flutter_clean_architecture/presentation/core/services/language_service.dart';
import 'package:flutter_clean_architecture/presentation/core/services/theme_service.dart';
import 'package:flutter_clean_architecture/presentation/pages/home/cubit/home_cubit.dart';
import 'package:flutter_clean_architecture/presentation/pages/setting/cubit/setting_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.I;

Future<void> init() async {

  /// PRESENTATION LAYER
  sl.registerFactory(
    () => HomeCubit(
      sharedPreferenceDataSource: sl()
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

  /// DATA LAYER

  /// MAIN INJECTOR & EXTERNAL LIBRARY
  sl.registerFactory(() => SharedPreferenceDataSource());

}