import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLhelper {
  // create table
  static Future<void> createTables(sql.Database db) async {
    await db.execute("""CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        email TEXT,
        password TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )""");
  }

  // create database

  static Future<sql.Database> Opendb() async {
    return sql.openDatabase(
      'datauser',
      version: 1,
      onCreate: (sql.Database db, int version) async {
        await createTables(db);
      },
    );
  }

// create new user
  static Future<int> AddNewUser(
      String name, String email, String password) async {
    final db = await SQLhelper.Opendb();
    final data = {'name': name, 'email': email, 'password': password};
    final id = db.insert('user', data);
    return id;
  }

  // checklogin
  static Future<List<Map>> Checklogin(String email, String password) async {
    final db = await SQLhelper.Opendb();
    final data = await db.rawQuery(
        "SELECT * FROM user WHERE email='$email' AND  password='$password'");
    if (data.isNotEmpty) {
      return data;
    }
    return data;
  }

  // check useralready exist
  static Future<List<Map>> userFound(String uname, String email) async {
    final db = await SQLhelper.Opendb();
    final data = await db
        .rawQuery("SELECT * FROM user WHERE name='$uname' AND  email='$email'");
    if (data.isNotEmpty) {
      return data;
    }
    return data;
  }

  static Future<List<Map>> getAll() async {
    final db = await SQLhelper.Opendb();
    final data = db.rawQuery('SELECT * from user');
    return data;
  }

  static Future<void> Deleteuser(int id) async {
    final db = await SQLhelper.Opendb();
    db.delete('user',where: 'id=?',whereArgs: [id]);
  }
}
