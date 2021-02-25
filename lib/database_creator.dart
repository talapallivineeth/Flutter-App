import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database db;

class DatabaseCreator {
  static const usertable = 'usertable';
  static const user_id = 'user_id';
  static const company_id = 'company_id';
  static const biz_id = 'biz_id';
  static const fname = 'fname';
  static const lname = 'lname';
  static const ppic = 'ppic';

  static void databaseLog(String functionName, String sql,
      [List<Map<String, dynamic>> selectQueryResult, int insertAndUpdateQueryResult, List<dynamic> params]) {
    print(functionName);
    print(sql);
    if (params != null) {
      print(params);
    }
    if (selectQueryResult != null) {
      print(selectQueryResult);
    } else if (insertAndUpdateQueryResult != null) {
      print(insertAndUpdateQueryResult);
    }
  }

  Future<void> createUserTable(Database db) async {
    final userSql = '''CREATE TABLE $usertable
    (
      $user_id TEXT PRIMARY KEY,
      $company_id TEXT,
      $biz_id TEXT,
      $fname TEXT,
      $lname TEXT,
      $ppic TEXT
    )''';

    await db.execute(userSql);
  }

  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    //make sure the folder exists
    if (await Directory(dirname(path)).exists()) {
      //await deleteDatabase(path);
    } else {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> initDatabase() async {
    final path = await getDatabasePath('user_db');
    db = await openDatabase(path, version: 1, onCreate: onCreate);
    print(db);
  }

  Future<void> onCreate(Database db, int version) async {
    await createUserTable(db);
  }
}