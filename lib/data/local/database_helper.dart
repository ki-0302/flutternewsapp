import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;
  static const String favoriteState = "favorite_state";

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE $favoriteState (id TEXT PRIMARY KEY, isFavorite INTEGER)',
        );
      },
    );
  }

  Future<void> updateFavoriteState(String url, bool isFavorite) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      favoriteState,
      where: 'id = ?',
      whereArgs: [url],
    );
    if (maps.isNotEmpty) {
      await db.update(
        favoriteState,
        {'isFavorite': isFavorite ? 1 : 0},
        where: 'id = ?',
        whereArgs: [url],
      );
    } else {
      await db.insert(
        favoriteState,
        {'id': url, 'isFavorite': isFavorite ? 1 : 0},
      );
    }
  }

  Future<bool> getFavoriteState(String url) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      favoriteState,
      where: 'id = ?',
      whereArgs: [url],
    );
    if (maps.isNotEmpty) {
      return maps.first['isFavorite'] == 1;
    } else {
      return false;
    }
  }
}
