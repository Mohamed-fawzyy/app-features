import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  //this fun for open the db connection
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    //folder carry path of db in the phone hard drive

    // open an existed db and if not found by its name auto create a new one with the same name
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)");
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table); //here u return all data of db, then u can filter it
  }
}
