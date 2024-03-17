import 'package:flutter_clean_architecture/domain/entities/user_github.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../utils/constant/const_values.dart';

class HiveDataSource {

  /// Init Hive Local Storage
  static Future<void> init() async {
    await Hive.initFlutter();

    /// Define the adapters
    Hive.registerAdapter(UserGithubAdapter());

    /// Open the boxes
    await Hive.openBox<UserGithub>(ConstValues.userGithubBox);
  }

  /// Get the boxes
  Box<UserGithub> get userGithubBox => Hive.box<UserGithub>(ConstValues.userGithubBox);

}