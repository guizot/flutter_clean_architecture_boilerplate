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

  /// GET CURRENT THEME FROM SHARED PREFERENCES
  Future<String> getCurrentTheme() async {
    final savedThemeMode = await sharedPreferenceDataSource.getString(SharedPreferencesValues.currentTheme);
    return savedThemeMode;
  }

  /// TOGGLE THEME
  void toggleTheme() {
    themeService.toggleTheme();
  }

}