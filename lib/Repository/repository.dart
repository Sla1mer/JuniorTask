import 'package:junior_front_end_development/Repository/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late DatabaseConnection _databaseConnection;

  // Инициализация подключения к базе данных
  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database?> get database async {
    if(_database!=null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  // Вставка данных
  insertData(table, data) async {
    var connection = await database;
    return await connection!.insert(table, data);
  }

  readData(table) async {
    var connection = await database;
    return await connection!.query(table);
  }


  deleteData(table, itemId) async {
    var connection = await database;
    return await connection!.rawDelete("DELETE FROM $table WHERE id = $itemId");
  }

  updateData(table, data) async {
    var connection = await database;
    return await connection!.update(table, data, where: "id=?", whereArgs: [data["id"]]);
  }

  readDataById(table, itemId) async {
    var connection = await database;
    return await connection!.query(table, where: "postId=?", whereArgs: [itemId]);
  }
}