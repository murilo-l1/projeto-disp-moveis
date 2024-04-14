import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// gráfico de pizza das despesas
class _PieChart extends StatelessWidget {
   _PieChart();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          'Despesas',
          style: TextStyle(fontSize: 18.0),
        ),
        // Pie Chart
        PieChart(
          swapAnimationDuration: Duration(milliseconds: 750),
          swapAnimationCurve: Curves.easeInOut,
          PieChartData(
            sections: [
              // saúde
              PieChartSectionData(
                value: 20, // esses valores serao mudados pela soma total na parte 2
                color: Colors.red,
                titlePositionPercentageOffset: 1.5
               ),
              // lazer
              PieChartSectionData(
                value: 20,
                color: Colors.yellow,
                titlePositionPercentageOffset: 1.5
                ),
              // transporte
              PieChartSectionData(
                value: 15,
                color: Colors.blue,
                titlePositionPercentageOffset: 1.5
              ),
              // alimentação
              PieChartSectionData(
                value: 20,
                color: Colors.green,
                titlePositionPercentageOffset: 1.5
                ),
            ],
          ),
        ),
        // Legend
        Positioned(
          left: 20,
          top: 0,
          bottom: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Legend items
              LegendItem(color: Colors.red, title: 'Saúde'),
              LegendItem(color: Colors.yellow, title: 'Lazer'),
              LegendItem(color: Colors.blue, title: 'Transporte'),
              LegendItem(color: Colors.green, title: 'Alimentação'),
            ],
          ),
        ),
      ],
    );
  }
}

// Widget for Legend Item
class LegendItem extends StatelessWidget {
  final Color color;
  final String title;

  const LegendItem({Key? key, required this.color, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 25,
          height: 25,
          color: color,
        ),
        SizedBox(width: 4),
        Text(title),
      ],
    );
  }
}