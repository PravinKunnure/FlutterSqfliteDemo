import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseLocal {

  createDatabase() async {
    String databasesPath = await getDatabasesPath();

    String dbPath = join(databasesPath, 'training.db');

    var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);

    print("Database Created");
    print(database);

    return database;
  }

  void populateDb(Database database, int version) async {

    var createTableQuery="CREATE TABLE VrittiMobileAppDevelopers ("
        "id INTEGER PRIMARY KEY,"
        "first_name TEXT,"
        "last_name TEXT,"
        "email TEXT"
        ")";

    await database.execute(createTableQuery);

    print("Table Created");
    print(createTableQuery);
  }

}