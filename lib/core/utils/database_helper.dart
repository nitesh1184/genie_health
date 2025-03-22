import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('patient_data.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE test_data (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        parameter TEXT,
        test1 REAL,
        test2 REAL,
        test3 REAL
      )
    ''');
  }

  Future<void> insertTestData(String parameter, double test1, double test2, double test3) async {
    final db = await instance.database;
    await db.insert('test_data', {
      'parameter': parameter,
      'test1': test1,
      'test2': test2,
      'test3': test3,
    });
  }

  Future<Map<String, dynamic>> getTestData() async {
    final db = await instance.database;
    final result = await db.query('test_data');
    Map<String, dynamic> testData = {};
    for (var row in result) {
      double test1 = (row['test1'] as num?)?.toDouble() ?? 0.0;
      double test2 = (row['test2'] as num?)?.toDouble() ?? 0.0;
      double test3 = (row['test3'] as num?)?.toDouble() ?? 0.0;

      testData[row['parameter'] as String] = {
        'test1': test1,
        'test2': test2,
        'test3': test3,
        'best': [test1, test2, test3].reduce((a, b) => a > b ? a : b),
      };
    }
    return testData;
  }

}