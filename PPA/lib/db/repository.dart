import 'package:ppa/db/Database.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late DatabaseConnection _databaseConnection;
  Repository() {
    _databaseConnection= DatabaseConnection();
  }
  static Database? _database;
  Future<Database?>get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }
  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }
  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }
  readDataById(table, itemId,password) async {
    var connection = await database;
    return await connection?.query(table, where: 'username=? AND pass=?', whereArgs: [itemId,password]);
  }
  updateData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }
  deleteDataById(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id=$itemId");
  }
  readDataByQ(table, text) async {
    var connection = await database;
    return await connection?.query(table, where: 'question=?', whereArgs: [text]);
  }
  readDataAccountById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }
  updateAccountData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }
}