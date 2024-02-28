import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/data/datasources/shared_preferences_data_source.dart';
import '../../../../data/utils/shared_preferences_values.dart';
import '../../../../injector.dart';
import '../../../core/services/theme_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeCubitState> {

  /// REGION: INIT CUBIT
  final SharedPreferenceDataSource sharedPreferenceDataSource;
  final ThemeService themeService;
  HomeCubit({
    required this.sharedPreferenceDataSource,
    required this.themeService
  }) : super(HomeInitial());

  /// TOGGLE THEME
  void toggleTheme(ThemeService notifier) {
    if(notifier.themeMode == ThemeData.dark()) {
      notifier.themeMode = ThemeData.light();
    } else {
      notifier.themeMode = ThemeData.dark();
    }
  }

}