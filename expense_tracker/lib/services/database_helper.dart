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
    try{
    
    final db = await _getDB();
    
    Future<int> result = db.insert('EXPENSES', expense.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    
    return result;
    }
    catch(e){
      print('error adding expense: $e' );
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

  static Future<List<Expense>?> getExpensesByMonth(String month) async{
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query('EXPENSES');

    if(maps.isEmpty){
      return null;
    }

    List<Expense> expenses = [];
    for (var map in maps) {
      Expense expense = Expense.fromJson(map);
      
      String expenseMonth = '${expense.date.year}-${expense.date.month}';
      if (expenseMonth == month) {
        expenses.add(expense);
      }
    }

    return expenses;
  }
}
