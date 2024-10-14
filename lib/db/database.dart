import 'package:path/path.dart';
import 'package:prueba_desis/models/user.dart';
import 'package:sqflite/sqflite.dart';

/// Clase para gestionar la base de datos SQLite.
class DBSqlite {
  static const String databaseName = 'user_database.db';
  static final DBSqlite _instance = DBSqlite._internal();
  factory DBSqlite() => _instance;

  static Database? _database;

  DBSqlite._internal();

  // Se obtiene la base de datos, creando una nueva si no existe.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // Inicializa la base de datos y se crean las tablas necesarias.
  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), databaseName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Se crea la tabla "users" con los atributos necesarios
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

  //Permite guardar un usuario en la base de datos
  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toJson());
  }

  // Obtiene los usuarios guardados en la base de datos y retorna una lista de usuarios
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
