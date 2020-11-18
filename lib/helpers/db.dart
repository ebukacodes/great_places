import 'package:sqflite/sqflite.dart' as SQL;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DB {
  static Future<Database> database() async {
    final dbPath = await SQL.getDatabasesPath();
    return SQL.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DB.database();

    db.insert(
      table,
      data,
      conflictAlgorithm: SQL.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DB.database();
    return db.query(table);
  }
}
