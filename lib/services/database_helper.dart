import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ui_demo/models/employee.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  Database _db;

  Future<Database> get database async {
    if (_db != null) return _db;

    _db = await initdatabase();
    return _db;
  }

  Future<Database> initdatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'employees.db');

    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) {
    db.execute(
        'create table employees(id integer primary key autoincrement, name text, post text,salary integer) ');
  }
}
