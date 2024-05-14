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

  // atualiza ususario
  static Future<void> updateUser(User user) async {
    try {
      final db = await _getDB();
      await db.update(
        'USERS',
        user.toJson(),
        where: 'id = ?',
        whereArgs: [user.id],
      );
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  // pega usuario
  Future<void> fetchUserDetails() async {
  try {
    // Obtém a lista de usuários do banco de dados
    List<User>? users = await DatabaseHelper.getUsers();
    
    // Verifica se a lista de usuários não é nula e não está vazia
    if (users != null && users.isNotEmpty) {
      // Aqui você pode acessar os detalhes do primeiro usuário na lista (ou qualquer outro usuário conforme necessário)
      User user = users[0]; // Supondo que você deseja os detalhes do primeiro usuário
      
      // Agora você pode acessar o nome e o email do usuário
      String name = user.name;
      String email = user.email;
      
      // Faça o que quiser com o nome e o email (exibir na interface do usuário, processar, etc.)
      print('Nome do usuário: $name');
      print('Email do usuário: $email');
    } else {
      print('Nenhum usuário encontrado no banco de dados.');
    }
  } catch (e) {
    print('Erro ao obter detalhes do usuário: $e');
  }
}

static Future<String?> getUserPassword(String email) async {
  try {
    final db = await _getDB();

    // Obtenha o usuário com o email fornecido
    List<Map<String, dynamic>> userMaps = await db.query(
      'USERS',
      where: 'email = ?',
      whereArgs: [email],
    );

    // Verifique se um usuário foi encontrado
    if (userMaps.isNotEmpty) {
      // Crie um objeto User a partir do Map
      User user = User.fromJson(userMaps.first);

      // Retorne a senha do usuário
      return user.password;
    } else {
      print('Nenhum usuário encontrado com o email: $email');
      return null;
    }
  } catch (e) {
    print('Erro ao obter a senha do usuário: $e');
    return null;
  }
}

static Future<String?> getUserName(String email) async {
  try {
    final db = await _getDB();

    // Obtenha o usuário com o email fornecido
    List<Map<String, dynamic>> userMaps = await db.query(
      'USERS',
      where: 'email = ?',
      whereArgs: [email],
    );

    // Verifique se um usuário foi encontrado
    if (userMaps.isNotEmpty) {
      // Crie um objeto User a partir do Map
      User user = User.fromJson(userMaps.first);

      // Retorne a senha do usuário
      return user.name;
    } else {
      print('Nenhum usuário encontrado com o email: $email');
      return null;
    }
  } catch (e) {
    print('Erro ao obter a senha do usuário: $e');
    return null;
  }
}

  /*
    static Future<void> updateUserEmail(String oldEmail, String newEmail) async {
    try {
      final db = await _getDB();

      // Primeiro, obtenha o usuário com o email antigo
      List<Map<String, dynamic>> userMaps = await db.query(
        'USERS',
        where: 'email = ?',
        whereArgs: [oldEmail],
      );

      // Verifique se um usuário foi encontrado
      if (userMaps.isNotEmpty) {
        // Crie um objeto User a partir do Map
        User user = User.fromJson(userMaps.first);

        // Atualize o email do usuário
        user.email = newEmail;

        // Atualize o usuário no banco de dados
        await db.update(
          'USERS',
          user.toJson(),
          where: 'id = ?',
          whereArgs: [user.id],
        );
      } else {
        print('Nenhum usuário encontrado com o email: $oldEmail');
      }
    } catch (e) {
      print('Erro ao atualizar o email do usuário: $e');
    }
  }
  */
  static Future<void> updateUserEmail(String oldEmail, String newEmail) async {
    // Obtenha uma referência para o banco de dados
    final db = await _getDB();

    // Atualize o e-mail do usuário
    await db.update(
      'users',
      {'email': newEmail},
      where: 'email = ?',
      whereArgs: [oldEmail],
    );
  }
  static Future<void> updateUserPassword(String email, String newPassword) async {
    // Obtenha uma referência para o banco de dados
    final db = await _getDB();

    // Atualize a senha do usuário
    await db.update(
      'users',
      {'password': newPassword},
      where: 'email = ?',
      whereArgs: [email],
    );
  }
  static Future<void> updateUserName(String email, String newName) async {
    // Obtenha a referência do banco de dados
    final db = await _getDB();

    // Atualize o nome do usuário
    await db.update(
      'users',
      {'name': newName},
      where: 'email = ?',
      whereArgs: [email],
    );
  }
}

