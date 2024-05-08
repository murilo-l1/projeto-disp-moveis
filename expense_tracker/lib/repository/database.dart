import 'package:sqflite/sqflite.dart';

class DB {
  // private constructor
  DB._();

  // instance of the database to realize operations
  static final DB instance = DB._();

  static Database? _database;

  get Database async {
    if (_database != null) return _database;
    _database = await _initDB();
  }

  _initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'expenses.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, versao) async {
    //await db.execute(_user); Arthur, pode usar aqui xD
    await db.execute(_expense);
    await db.insert('users', {'name': 'admin', 'password': 'admin'});
    await db.insert('expenses', {
      'name': 'Aluguel',
      'value': 1000.0,
      'date': '2021-09-01',
      'category': 'Transporte'
    });
  }

  // criando uma tabela que vai armazenar as informacoes inseriadas pelo usuario na dialogue box
  get _expense => '''
                CREATE TABLE(expenses)(
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  name TEXT,
                  value REAL,
                  date TEXT,
                  category TEXT
                )

''';
}
