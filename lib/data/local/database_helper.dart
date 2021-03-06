import 'package:restaurant_app/data/local/restaurants_entity.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  static String _tableName = "list_restaurant";

  DatabaseHelper._createObject();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createObject();
    }

    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }
    return _database;
  }

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurant_db.db',
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (id STRING PRIMARY KEY,
          name TEXT, description TEXT, picture TEXT, city TEXT)''',
        );
      },
      version: 1,
    );
    return db;
  }

  Future<void> insertRestaurant(RestaurantsEntity restaurantsEntity) async {
    final Database db = await database;
    await db.insert(_tableName, restaurantsEntity.toMap());
    print('Insert Success');
  }

  Future<List<RestaurantsEntity>> getRestaurant() async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query(_tableName);

    return result.map((res) => RestaurantsEntity.fromMap(res)).toList();
  }

  Future<RestaurantsEntity> getRestaurantById(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query(_tableName, where: 'id = ?', whereArgs: [id]);
    return results.map((e) => RestaurantsEntity.fromMap(e)).first;
  }

  Future<List<RestaurantsEntity>> getRestaurantByIdSize(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query(_tableName, where: 'id = ?', whereArgs: [id]);

    return results.map((res) => RestaurantsEntity.fromMap(res)).toList();
  }

  Future<void> deleteRestaurantById(String id) async {
    final db = await database;

    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
    print('Delete Success');
  }
}
