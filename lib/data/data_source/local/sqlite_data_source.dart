import 'package:flutter_clean_architecture/domain/entities/user_github.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../utils/constant/const_values.dart';

class SqliteDataSource {

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'database.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('CREATE TABLE IF NOT EXISTS ${ConstValues.moviesTable}(id INTEGER PRIMARY KEY, title TEXT, overview TEXT, poster_path TEXT)');
      },
    );
  }

}