// criando uma classe padrão para registro de gastos, com o uso da isar db esse modelo pode passar de classe para entidade do banco mais facilmente
import 'package:isar/isar.dart';
// part "expense.g.dart"; assim vamos poder gerar o object que o banco vai consumir posteriormente

class Expense{
  // os campos são id (que se mantem unica com autoIncrement), nome, valor e data da mesma

  Id id = Isar.autoIncrement;
  final String name;
  final double amount;
  final DateTime date;

  // construtor da despesa
  Expense(
    {required this.name,
    required this.amount,
    required this.date}
    );
}