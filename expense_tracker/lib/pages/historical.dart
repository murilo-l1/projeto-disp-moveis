import 'package:expense_tracker/repository/enums.dart';
import 'package:expense_tracker/pages/home.dart';
import 'package:expense_tracker/pages/profile/components/customBottomBar.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/charts/barChart.dart';

class HistoricalPage extends StatefulWidget {
  const HistoricalPage({super.key});

  @override
  State<HistoricalPage> createState() => _HistoricalPageState();
}

class _HistoricalPageState extends State<HistoricalPage> {
  List<double> monthExpenses = [
    10.0,
    20.0,
    30.0,
    40.0,
    50.0,
    60.0,
    70.0,
    80.0,
    90.0,
    10.0,
    11.0,
    120.0
  ];

  List<Expense> expenses = [
    Expense(
        name: 'Mercado',
        date: DateTime(2024, 4, 1),
        amount: 30.0,
        category: 'Alimentação'),
    Expense(
        date: DateTime(2024, 4, 5),
        amount: 12.0,
        category: 'Transporte',
        name: 'Uber'),
    Expense(
        name: 'Restaurante',
        date: DateTime(2024, 4, 10),
        amount: 50.0,
        category: 'Alimentação'),
    Expense(
        date: DateTime(2024, 4, 15),
        amount: 25.0,
        category: 'Transporte',
        name: 'Taxi'),
    Expense(
        name: 'Roupas',
        date: DateTime(2024, 4, 20),
        amount: 80.0,
        category: 'Vestuário'),
    Expense(
        date: DateTime(2024, 4, 25),
        amount: 40.0,
        category: 'Transporte',
        name: 'Ônibus'),
    Expense(
        name: 'Cinema',
        date: DateTime(2024, 4, 28),
        amount: 35.0,
        category: 'Lazer'),
    Expense(
        date: DateTime(2024, 4, 30),
        amount: 20.0,
        category: 'Lazer',
        name: 'Parque'),
    Expense(
        name: 'Viagem',
        date: DateTime(2024, 4, 30),
        amount: 200.0,
        category: 'Lazer'),
    Expense(
        date: DateTime(2024, 4, 30),
        amount: 15.0,
        category: 'Lazer',
        name: 'Museu'),
    Expense(
        name: 'Livros',
        date: DateTime(2024, 4, 30),
        amount: 50.0,
        category: 'Lazer'),
    // mais despesas conforme necessário (vai virar banco de dados)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[200],
      appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Text(
            'Gastos Totais: R\$ ${calculateTotalExpenses(monthExpenses).toStringAsFixed(2)}',
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 20,
              //fontStyle: FontStyle.italic,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 20), // Ajuste conforme necessário
            child: SizedBox(
              height: 200,
              child: BarChartImpl(monthExpenses: monthExpenses),
            ),
          ),
          const SizedBox(height: 50),
          // aqui ficara a lista de historico de gastos
          buildScrollExpenseList(expenses),
        ],
      ),
      bottomNavigationBar: const customBottomBarNav(
        selectedMenu: MenuState.bar_chart,
      ),
    );
  }
}

double calculateTotalExpenses(List<double> monthExpenses) {
  double total = 0;
  for (int i = 0; i < monthExpenses.length; i++) {
    total += monthExpenses[i];
  }
  return total;
}

// classe usada para salvar os gastos que serão apresentados na lista de histórico
class Expense {
  final String name;
  final DateTime date;
  final double amount;
  final String category;

  Expense(
      {required this.name,
      required this.date,
      required this.amount,
      required this.category});
}

//criar um historico scrollavel com apenas itens arbitrarios para teste
Widget buildScrollExpenseList(List<Expense> expenses) {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Lista de gastos
          ListView.builder(
            shrinkWrap: true,
            itemCount: expenses.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  expenses[index].name,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 56, 55, 55),
                  ),
                  textAlign:
                      TextAlign.start, // Centraliza o texto horizontalmente
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'R\$ ${expenses[index].amount.toStringAsFixed(2)}',
                    ),
                    Text(
                      expenses[index].category,
                    ),
                  ],
                ),
                trailing: Text(
                  '${expenses[index].date.day}/${expenses[index].date.month}/${expenses[index].date.year}',
                  style: const TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 56, 55, 55)),
                ),
              );
            },
          )
        ],
      ),
    ),
  );
}
