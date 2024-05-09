import 'package:expense_tracker/models/expense_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // isso é usado pra conseguir dar update no banco de dados
  static const int _version = 1;
  static const String _databaseName = 'expense_tracker.db';

  // quando for adicionar usuarios criaremos uma tabela para ele, e a table de despesas tambem vai ter um usuario como campo!

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _databaseName),
        onCreate: (db, version) async => await db.execute(
              'CREATE TABLE EXPENSES(id INTEGER PRIMARY KEY, name TEXT, amount REAL, date TEXT, category TEXT)',
            ),
        version: _version);
  }

  static Future<int> addExpense(Expense expense) async {
    final db = await _getDB();
    return await db.insert('EXPENSES', expense.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Expense>?> getExpenses() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query('EXPENSES');

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Expense.fromJson(maps[index]));
  }
}
