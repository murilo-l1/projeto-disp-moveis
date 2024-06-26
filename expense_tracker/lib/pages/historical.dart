import 'package:expense_tracker/enum/enums.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/pages/home.dart';
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

  @override
  void initState() {
    super.initState();
    fetchExpenses();
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

  List<double> createMonthExpensesList() {
    List<double> monthExpenses = List.filled(12, 0.0);

    for (int i = 0; i < 12; i++) {
      // Convert month number to string (1-based)
      String monthString = (i + 1).toString().padLeft(2, '0');
      String yearMonth = '${DateTime.now().year}-$monthString';

      // Filter expenses by month
      List<Expense> expensesInMonth = expenses
          .where((expense) =>
              '${expense.date.year}-${expense.date.month.toString().padLeft(2, '0')}' ==
              yearMonth)
          .toList();

      // Calculate total expenses in the month
      double totalExpensesInMonth =
          expensesInMonth.fold(0, (sum, expense) => sum + expense.amount);

      monthExpenses[i] = totalExpensesInMonth;
    }

    return monthExpenses;
  }

  @override
  Widget build(BuildContext context) {
    List<double> monthExpenses = createMonthExpensesList();
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
