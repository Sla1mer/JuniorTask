import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, "db_posts_sqflite");
    var database = await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    await database.execute(
        "CREATE TABLE posts (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, body TEXT)");

    await database.execute(
        "CREATE TABLE comments (id INTEGER PRIMARY KEY AUTOINCREMENT, postId INTEGER, text TEXT)");
  }
}

// CREATE TABLE comments (id INTEGER PRIMARY KEY AUTOINCREMENT, postId INTEGER, text TEXT)