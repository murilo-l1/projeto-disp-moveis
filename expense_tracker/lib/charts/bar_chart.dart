import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/* class _BarChart extends StatefulWidget {
  const _BarChart({super.key});

  @override
  State<_BarChart> createState() => _BarChartState();
} */

/* class _BarChartState extends State<_BarChart>{
  final List<double> monthExpenses = [
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
  
  @override
  Widget build(BuildContext context) {
    return _BarChart(monthExpenses: expenseList);
  }

  



} */


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
  const _BarChart({required this.monthExpenses});

  @override
  Widget build(BuildContext context) {
    BarData barData = BarData(
      januaryAmount: monthExpenses[0], 
      februaryAmout: monthExpenses[1], 
      marchAmout: monthExpenses[2], 
      aprilAmount: monthExpenses[3], 
      mayAmount: monthExpenses[4],
      juneAmount: monthExpenses[5],
      julyAmount:  monthExpenses[6],
      augustAmount: monthExpenses[7],
       septemberAmount: monthExpenses[8],
       octoberAmount: monthExpenses[9],
       novemberAmount: monthExpenses[10],
       decemberAmount: monthExpenses[11],
       );
      barData.initializeBarData();

    return BarChart(
      BarChartData(
        maxY: 100,
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          // aqui a gente vai chamar a função que muda as coisas de numeros para meses
          bottomTitles: AxisTitles(sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getBottomTitles,
          ),
          ),
          ),
        barGroups: barData.barData.
        map(
          (data) => BarChartGroupData(
          x: data.x,
          barRods: [
            BarChartRodData(
              toY: data.y,
              color: Colors.grey[700],
              width: 18,
              borderRadius: BorderRadius.circular(4),
              )
          ],
        )).toList(),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta){

  const style = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 14,
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