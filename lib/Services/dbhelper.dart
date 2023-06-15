import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._getInstance();
  static Database? _database;

  DatabaseHelper._getInstance();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'test_scores.db');

    return await openDatabase(
      databasePath,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE test_scores(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        score INTEGER
      )
    ''');
  }

  Future<void> insertScore(String username, int score) async {
    final db = await database;
    await db.insert(
      'test_scores',
      {'username': username, 'score': score},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getScores() async {
    final db = await database;
    return await db.query('test_scores');
  }

  Future<void> clearScores() async {
    final db = await database;
    await db.delete('test_scores');
  }

}