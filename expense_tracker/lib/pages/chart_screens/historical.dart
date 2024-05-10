import 'package:expense_tracker/enum/enums.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/pages/chart_screens/home.dart';
import 'package:expense_tracker/pages/profile/components/customBottomBar.dart';
import 'package:expense_tracker/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/charts/barChart.dart';

class HistoricalPage extends StatefulWidget {
  const HistoricalPage({super.key});

  @override
  State<HistoricalPage> createState() => _HistoricalPageState();
}

class _HistoricalPageState extends State<HistoricalPage> {


List<Expense> expenses = [];
List<double> monthExpenses = [
  10,
  20,
  30,
  40,
  12,
  10,
  10,
  16,
  20,
  80,
  60,
  15
];
    
    @override
  void initState() {
    super.initState();
    fetchExpenses(); // quando inicializar a pagina vai la no banco buscar as despesas e criar uma lista com esses dados
  }

  Future<void> fetchExpenses() async {
  List<Expense>? fetchedExpenses = await DatabaseHelper.getExpenses();
  
  if (fetchedExpenses != null && fetchedExpenses.isNotEmpty) {
    setState(() {
      expenses = fetchedExpenses;
    });
  } else {
    setState(() {
      expenses = [];
      //monthExpenses = List.filled(12, 0);
    });
  }
}

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
            'Gastos Totais: R\$ ${calculateTotalExpenses(expenses).toStringAsFixed(2)}',
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

double calculateTotalExpenses(List<Expense> expenses) {
  double total = 0;
  for (int i = 0; i < expenses.length; i++) {
    total = total + expenses[i].amount;
  }
  return total;
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