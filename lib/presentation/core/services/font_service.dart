import 'package:flutter/cupertino.dart';
import '../../../data/data_source/shared/shared_preferences_data_source.dart';

class FontService extends ChangeNotifier {

  final SharedPreferenceDataSource sharedPreferenceDataSource;
  FontService({required this.sharedPreferenceDataSource}) {}

}