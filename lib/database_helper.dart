import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'DeviceData.dart';



class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

Future<void> deleteAllDeviceData() async {
    final db = await database;
    await db.delete('device_data');  
  }
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('devices.db');
    return _database!;
  }

  Future<Database> _initDB(String path) async {
    final dbPath = await getDatabasesPath();
    final fullPath = join(dbPath, path);
    return openDatabase(fullPath, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE device_data (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        serial TEXT,
        name TEXT,
        dateTime TEXT,
        co REAL,
        so REAL,
        pm25 REAL
      )
    ''');
  }

  Future<void> insertDeviceData(DeviceData deviceData) async {
    final db = await instance.database;
    await db.insert('device_data', deviceData.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<DeviceData>> getDeviceData() async {
    final db = await instance.database;
    final result = await db.query('device_data');
    return result.map((map) => DeviceData.fromMap(map)).toList();
  }
}
