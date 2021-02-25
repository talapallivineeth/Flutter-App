
import 'package:bizwyapp/user_db.dart';
import 'package:sqflite/sqflite.dart';

import 'database_creator.dart';

class RepositoryService{
  static Future<UserDb> getUser(String id) async {
    //final sql = '''SELECT * FROM ${DatabaseCreator.usertable}
    //WHERE ${DatabaseCreator.user_id} = ?''';

    //List<dynamic> params = [id];
    final data = await db.query(DatabaseCreator.usertable, where: "${DatabaseCreator.user_id} = ?", whereArgs: [id]);
    final u=UserDb.fromJson(data.first);
    return u;
  }
  static Future<void> addUser(UserDb userDb) async {
    var re=await db.insert(DatabaseCreator.usertable,userDb.toMap());
    print(re);
  }
  static Future<int> checkUser(String id) async{
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT * from ${DatabaseCreator.usertable} WHERE ${DatabaseCreator.user_id}==$id');
    //int result = Sqflite.firstIntValue(x);
    int result=x.isEmpty?0:1;
    print(result);
    return result;
  }
}