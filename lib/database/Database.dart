import 'dart:async';
import 'package:centsei/models/category.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/parsing.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

class CentseiDatabase {
  late Future<dynamic> database;

  CentseiDatabase() {
    database = _initializeDatabase();
  }

  _initializeDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'centsei.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE categories(id VARCHAR(256), title VARCHAR(32), target DOUBLE, actual DOUBLE)');
      },
      version: 1,
    );
  }

  Future<List<Category>> categories() async {
    final db = await database;

    final List<Map<String, Object?>> categoryMaps = await db.query('categories');

    return [
      for (final {
        'id': id as String,
        'title': title as String,
        'target': target as double,
      } in categoryMaps)
        Category(UuidV4(), title, target),
    ];
  }

  Future<void> insertCategory(Category category) async {
    final db = await database;

    await db.insert(
      'categories',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

}
