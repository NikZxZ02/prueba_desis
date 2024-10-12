import 'package:path/path.dart';
import 'package:prueba_desis/models/user.dart';
import 'package:sqflite/sqflite.dart';

class DBSqlite {
  static const String databaseName = 'user_database.db';
  static final DBSqlite _instance = DBSqlite._internal();
  factory DBSqlite() => _instance;

  static Database? _database;

  DBSqlite._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), databaseName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        birthDate TEXT,
        address TEXT,
        password TEXT
      )
    ''');
  }

  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toJson());
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        name: maps[i]['name'],
        email: maps[i]['email'],
        birthDate: maps[i]['birthDate'],
        address: maps[i]['address'],
        password: maps[i]['password'],
      );
    });
  }
}
