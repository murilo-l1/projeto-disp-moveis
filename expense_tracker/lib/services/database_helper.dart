import 'dart:ffi';

import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // isso é usado pra conseguir dar update no banco de dados
  static const int _version = 1;
  static const String _databaseName = 'expense_tracker.db';

  // Pra poder adicionar o campo de usuário corretamente é necessário adicionar:
  // userId INTEGER FOREIGN KEY(userId) REFERENCES USERS(id)
  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _databaseName),
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE EXPENSES(id INTEGER PRIMARY KEY, name TEXT, amount REAL, date TEXT, category TEXT)');
      await db.execute(
          'CREATE TABLE USERS(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, password TEXT)');
    }, version: _version);
  }

  static Future<int> addExpense(Expense expense) async {
    try {
      final db = await _getDB();
      Future<int> result = db.insert('EXPENSES', expense.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);

      return result;
    } catch (e) {
      print('error adding expense: $e');
      return 0;
    }
  }

  static Future<List<Expense>?> getExpenses() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query('EXPENSES');

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Expense.fromJson(maps[index]));
  }

  static Future<void> resetExpenses() async {
    try {
      final db = await _getDB();

      await db.delete('EXPENSES');
    } catch (e) {
      print('Error resetting EXPENSES table: $e');
    }
  }

  // LOGIN METHOD
  Future<bool> Login(User USERS) async {
    final db = await _getDB();

    var result = await db.rawQuery(
        "select * from USERS where email = '${USERS.email}' AND password = '${USERS.password}'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  // SIGN UP METHOD
  Future<int> signup(User USERS) async {
    final db = await _getDB();
    final int userId = await db.insert('USERS', USERS.toJson());
    print(
        'Novo usuário cadastrado - Email: ${USERS.email}, Senha: ${USERS.password}');
    return userId;
  }

  //sim isso aqui
  static Future<List<User>?> getUsers() async {
    try {
      final db = await _getDB();
      final List<Map<String, dynamic>> maps = await db.query('USERS');

      if (maps.isNotEmpty) {
        return List.generate(
            maps.length, (index) => User.fromJson(maps[index]));
      } else {
        return null;
      }
    } catch (e) {
      print('Erro ao obter usuários: $e');
      return null;
    }
  }
}
