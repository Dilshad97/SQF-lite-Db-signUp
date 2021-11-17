import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

class Dbmanager {
  Database? _database;

  Future openDB() async {
    if (_database != null) {
      _database = await openDatabase(
        join(await getDatabasesPath(), "student.db"),
        version: 1,
        onCreate: (Database db, version) async {
          await db.execute(
              "CREATE TABLE student (user_id, STRING PRIMARYKEY autoincrement,user_name TEXT, user_name TEXT, email TEXT, password TEXT)");
        },
      );
    }
  }

  Future<int> InsertDb(Student student) async {
    await openDB();
    return await _database!.insert('student', student.toMap());
  }

  Future<List<Student>> getList() async {
    await openDB();
    final List<Map<String, dynamic>> maps = await _database!.query('student');
    return List.generate(maps.length, (index) {
      return Student(
          password: maps[index]['password'],
          email: maps[index]['email'],
          user_id: maps[index]['user_id'],
          user_name: maps[index]['user_name']);
    });
  }

  Future<int> Update(Student student) async {
    await openDB();
    return await _database!.update("student", student.toMap(),
        where: "id=?", whereArgs: [student.user_id]);
  }

  Future<void> delete(String user_id) async {
    await openDB();
    await _database!.delete("student", where: "id=?", whereArgs: [user_id]);

  }


}

class Student {
  String? user_id;
  String? user_name;
  String? email;
  String? password;

  Student({required this.password,
    required this.email,
    required this.user_id,
    required this.user_name});

  Map<String, dynamic> toMap() {
    return {
      'user_name': user_name,
      'user_id': user_id,
      'email': email,
      'password': password
    };
  }
}
