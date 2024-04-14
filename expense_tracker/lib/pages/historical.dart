import 'dart:math';

import 'package:expense_tracker/models/enums.dart';
import 'package:expense_tracker/pages/home.dart';
import 'package:expense_tracker/pages/profile/components/customBottomBar.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
    Expense(name: 'Mercado', date: DateTime(2024, 4, 1), amount: 30.0, category: 'Alimentação'),
    Expense(date: DateTime(2024, 4, 5), amount: 12.0, category: 'Transporte', name: 'Uber'),	
    Expense(name: 'Restaurante', date: DateTime(2024, 4, 10), amount: 50.0, category: 'Alimentação'),
    Expense(date: DateTime(2024, 4, 15), amount: 25.0, category: 'Transporte', name: 'Taxi'),
    Expense(name: 'Roupas', date: DateTime(2024, 4, 20), amount: 80.0, category: 'Vestuário'),
    Expense(date: DateTime(2024, 4, 25), amount: 40.0, category: 'Transporte', name: 'Ônibus'),
    Expense(name: 'Cinema', date: DateTime(2024, 4, 28), amount: 35.0, category: 'Lazer'),
    Expense(date: DateTime(2024, 4, 30), amount: 20.0, category: 'Lazer', name: 'Parque'),
    Expense(name: 'Viagem', date: DateTime(2024, 4, 30), amount: 200.0, category: 'Lazer'),
    Expense(date: DateTime(2024, 4, 30), amount: 15.0, category: 'Lazer', name: 'Museu'),
    Expense(name: 'Livros', date: DateTime(2024, 4, 30), amount: 50.0, category: 'Lazer'),
    // mais despesas conforme necessário (vai virar banco de dados)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.grey[200],
      appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 10),
          Text(
            'Gastos Totais: R\$ ${calculateTotalExpenses(monthExpenses).toStringAsFixed(2)}' ,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20), // Ajuste conforme necessário
            child: SizedBox(
              height: 200,
              child: _BarChart(monthExpenses: monthExpenses),
            ),
          ),
          SizedBox(height: 50),
          // aqui ficara a lista de historico de gastos
          buildScrollExpenseList(expenses),
          ],
      ),
      bottomNavigationBar: customBottomBarNav(
        selectedMenu: MenuState.bar_chart,
      ),
    );
  }
}

//criar um grafico de barras com 12 barras, uma para cada mes do ano
class IndividualBar {
  final int x; 
  final double y;
 
  IndividualBar({
    required this.x, 
    required this.y
    });
}

class BarData{
  final double januaryAmount;
  final double februaryAmout;
  final double marchAmout;
  final double aprilAmount;
  final double mayAmount;
  final double juneAmount;
  final double julyAmount;
  final double augustAmount;
  final double septemberAmount;
  final double octoberAmount;
  final double novemberAmount;
  final double decemberAmount;

  BarData({
    required this.januaryAmount,
    required this.februaryAmout,
    required this.marchAmout,
    required this.aprilAmount,
    required this.mayAmount,
    required this.juneAmount,
    required this.julyAmount,
    required this.augustAmount,
    required this.septemberAmount,
    required this.octoberAmount,
    required this.novemberAmount,
    required this.decemberAmount
  });

  List<IndividualBar> barData = [];


  //inicializando os valores das barras respectivos aos gastos de cada mes
  void initializeBarData(){
      barData = [
        IndividualBar(x: 0, y: januaryAmount),
        IndividualBar(x: 1, y: februaryAmout),
        IndividualBar(x: 2, y: marchAmout),
        IndividualBar(x: 3, y: aprilAmount),
        IndividualBar(x: 4, y: mayAmount),
        IndividualBar(x: 5, y: juneAmount),
        IndividualBar(x: 6, y: julyAmount),
        IndividualBar(x: 7, y: augustAmount),
        IndividualBar(x: 8, y: septemberAmount),
        IndividualBar(x: 9, y: octoberAmount),
        IndividualBar(x: 10, y: novemberAmount),
        IndividualBar(x: 11, y: decemberAmount),
        ];

  }
}


class _BarChart extends StatelessWidget {
  final List monthExpenses;
  const _BarChart({Key? key, required this.monthExpenses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BarData barData = BarData(
      januaryAmount: monthExpenses[0],
      februaryAmout: monthExpenses[1],
      marchAmout: monthExpenses[2],
      aprilAmount: monthExpenses[3],
      mayAmount: monthExpenses[4],
      juneAmount: monthExpenses[5],
      julyAmount: monthExpenses[6],
      augustAmount: monthExpenses[7],
      septemberAmount: monthExpenses[8],
      octoberAmount: monthExpenses[9],
      novemberAmount: monthExpenses[10],
      decemberAmount: monthExpenses[11],
    );
    barData.initializeBarData();

    return Container(
      height: 250, 
      child: BarChart(
        BarChartData(
          maxY: 100,
          minY: 0,
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: getBottomTitles,
              ),
            ),
          ),
          barGroups: barData.barData.map(
            (data) => BarChartGroupData(
              x: data.x,
              barRods: [
                BarChartRodData(
                  toY: data.y,
                  color: Colors.blue[500],
                  width: 20,
                  borderRadius: BorderRadius.circular(6),
                )
              ],
            ),
          ).toList(),
        ),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta){

  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 10,
  );

  Widget text;

  switch(value.toInt()){
    case 0:
      text = Text('Jan', style: style);
      break;
    case 1:
      text = Text('Fev', style: style);
      break;
    case 2:
      text = Text('Mar', style: style);
      break;
    case 3:
      text = Text('Abr', style: style);
      break;
    case 4:
      text = Text('Mai', style: style);
      break;
    case 5:
      text = Text('Jun', style: style);
      break;
    case 6:
      text = Text('Jul', style: style);
      break;
    case 7:
      text = Text('Ago', style: style);
      break;
    case 8:
      text = Text('Set', style: style);
      break;
    case 9: 
      text = Text('Out', style: style);
      break;
    case 10:
      text = Text('Nov', style: style);
      break;
    case 11:
      text = Text('Dez', style: style);
      break;
    default:
      text = Text('', style: style);
}

  return SideTitleWidget(child: text, axisSide: meta.axisSide);

}

double calculateTotalExpenses(List<double> monthExpenses){
  double total = 0;
  for (int i = 0; i < monthExpenses.length; i++){
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

  Expense({required this.name, required this.date, required this.amount, required this.category});
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
                  style: TextStyle(
                    fontSize: 20,
                    color: const Color.fromARGB(255, 56, 55, 55),
                  ),
                  textAlign: TextAlign.start, // Centraliza o texto horizontalmente
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
                  style: TextStyle(
                    fontSize: 15,
                    color: const Color.fromARGB(255, 56, 55, 55)
                  ),
                ),
              );
            },
          )
        ],
      ),
    ),
  );
}