import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartImpl extends StatefulWidget {
  const PieChartImpl({super.key});

  @override
  _PieChartImplState createState() => _PieChartImplState();
}

class _PieChartImplState extends State<PieChartImpl> {
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
      });
    }
  }

  List<double> getExpensesByCategory(List<Expense> expenses) {
    List<double> expensesByCategory = List.filled(4, 0.0);

    for (Expense expense in expenses) {
      switch (expense.category) {
        case 'Saúde':
          expensesByCategory[0] += expense.amount;
          break;
        case 'Lazer':
          expensesByCategory[1] += expense.amount;
          break;
        case 'Transporte':
          expensesByCategory[2] += expense.amount;
          break;
        case 'Alimentação':
          expensesByCategory[3] += expense.amount;
          break;
        default:
          break;
      }
    }

    return expensesByCategory;
  }

  @override
  Widget build(BuildContext context) {
    List<double> expensesByCategory = getExpensesByCategory(expenses);
    double totalExpenses = expensesByCategory.reduce((a, b) => a + b);

    // linha de código pra não ficar um despesas em vão, pode ser melhor só tirar isso no futuro.
    if (totalExpenses == 0) {
      Alignment.topCenter;
      return const Text(
        'Adicione uma despesa para começar!',
        style: TextStyle(fontSize: 22.0, fontStyle: FontStyle.italic),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        const Text(
          'Despesas',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Pie Chart
        PieChart(
          swapAnimationDuration: const Duration(milliseconds: 750),
          swapAnimationCurve: Curves.easeInOut,
          PieChartData(
            sections: [
              // saúde
              PieChartSectionData(
                value: expensesByCategory[0],
                color: const Color.fromARGB(255, 164, 76, 76),
                radius: 80,
                borderSide: const BorderSide(color: Colors.black, width: 0.5),
                title:
                    '${((expensesByCategory[0] / totalExpenses) * 100).toStringAsFixed(1)}%',
              ),
              // lazer
              PieChartSectionData(
                value: expensesByCategory[1],
                color: const Color.fromARGB(255, 212, 151, 85),
                radius: 80,
                borderSide: const BorderSide(color: Colors.black, width: 0.5),
                title:
                    '${((expensesByCategory[1] / totalExpenses) * 100).toStringAsFixed(1)}%',
              ),
              // transporte
              PieChartSectionData(
                value: expensesByCategory[2],
                color: const Color.fromARGB(255, 19, 108, 181),
                radius: 80,
                borderSide: const BorderSide(color: Colors.black, width: 0.5),
                title:
                    '${((expensesByCategory[2] / totalExpenses) * 100).toStringAsFixed(1)}%',
              ),
              // alimentação
              PieChartSectionData(
                value: expensesByCategory[3],
                color: const Color.fromARGB(255, 109, 192, 114),
                radius: 80,
                borderSide: const BorderSide(color: Colors.black, width: 0.5),
                title:
                    '${((expensesByCategory[3] / totalExpenses) * 100).toStringAsFixed(1)}%',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Legend extends StatelessWidget {
  const Legend({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Legend items
        LegendItem(
          color: Color.fromARGB(255, 164, 76, 76),
          title: 'Saúde',
        ),
        LegendItem(
          color: Color.fromARGB(255, 212, 151, 85),
          title: 'Lazer',
        ),
        LegendItem(
          color: Color.fromARGB(255, 19, 108, 181),
          title: 'Transporte',
        ),
        LegendItem(
          color: Color.fromARGB(255, 109, 192, 114),
          title: 'Alimentação',
        ),
      ],
    );
  }
}

// Selecao das legendas que vao ficar do lado do grafico, essa é a box delas
class LegendItem extends StatelessWidget {
  final Color color;
  final String title;

  const LegendItem({super.key, required this.color, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          color: color,
        ),
        const SizedBox(width: 5),
        Text(title),
      ],
    );
  }
}
