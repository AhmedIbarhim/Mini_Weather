import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static late Database database;

  static Future<void> initDatabase() async {
    String pathDatabase = await getDatabasesPath();
    pathDatabase += "local.db";
    database = await openDatabase(pathDatabase, version: 1,
        onCreate: (database, version) {
      print("Database Created!!");
      database
          .execute("CREATE TABLE CITIES (id INTEGER PRIMARY KEY, name TEXT)")
          .then((value) {
        print("Table CITIES is Created !!");
      }).catchError((error) {
        print(error.toString());
      });
    }, onOpen: (database) {
      print("Database Opened!!");
    });
  }

  static Future<void> insertData({required String city}) async {
    database.insert("CITIES", {"name": city}).then((value) {
      print("value inserted successfully");
    }).catchError((error) {
      print(error.toString());
    });
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    List<Map<String, dynamic>> result = [];
    await database.rawQuery("SELECT * FROM CITIES").then((value) {
      result = value;
    }).catchError((error) {
      print(error.toString());
    });
    return result;
  }

  static Future<void> deleteData(String name) async {
    database
        .delete("CITIES", where: "name = ?", whereArgs: [name]).then((value) {
      print("value deleted successfully");
    }).catchError((error) {
      print(error.toString());
    });
  }
}
