import 'dart:async';
import 'package:centsei/models/category.dart';
import 'package:centsei/models/transaction.dart' as centsei;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class Database {
  late Future<dynamic> database;

  Database() {
    database = _initializeDatabase();
  }

  _initializeDatabase() async {
    return sqflite.openDatabase(
      join(await sqflite.getDatabasesPath(), 'centsei.db'),
      onCreate: (db, version) {
        return db.execute(
          """
            CREATE TABLE categories(id VARCHAR(256), title VARCHAR(32), target DOUBLE, actual DOUBLE);
            CREATE TABLE transactions(id VARCHAR(256), merchant VARCHAR(32), description VARCHAR(64), amount DOUBLE);
          """
        );
      },
      version: 1,
    );
  }

  Future<List<Category>> categories() async {
    final db = await database;

    final List<Map<String, Object?>> categoryMaps = await db.query('categories');

    return [
      for (final {
        'title': title as String,
        'target': target as double,
      } in categoryMaps)
        Category(title, target),
    ];
  }

  Future<List<centsei.Transaction>> transactions() async {
    final db = await database;

    final List<Map<String, Object?>> transactionMaps = await db.query('transactions');

    return [
      for (final {
      'merchant': merchant as String,
      'description': description as String,
      'amount': amount as double,
      } in transactionMaps)
        centsei.Transaction(merchant, description, amount),
    ];
  }

  Future<void> insertCategory(Category category) async {
    final db = await database;

    await db.insert(
      'categories',
      category.toMap(),
      conflictAlgorithm: sqflite.ConflictAlgorithm.replace,
    );
  }

}
