import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


// gráfico de pizza das despesas
// isso daqui eventualmente tem que estar em outro lugar e procurar arrumar a posicao da legenda
class PieChartImpl extends StatelessWidget {
   const PieChartImpl({super.key});

  @override
  Widget build(BuildContext context) {
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
                value: 20, // esses valores serao mudados pela soma total na parte 2
                color: const Color.fromARGB(255, 164, 76, 76),
                radius: 80,
                borderSide: const BorderSide(color: Colors.black, width: 0.5),
                title: '20%'
                ),
              // lazer
              PieChartSectionData(
                value: 20,
                color: const Color.fromARGB(255, 212, 151, 85),
                radius: 80,
                borderSide: const BorderSide(color: Colors.black, width: 0.5),
                title: '20%'
                ),
              // transporte
              PieChartSectionData(
                value: 40,
                color: const Color.fromARGB(255, 19, 108, 181),
                radius: 80,
                borderSide: const BorderSide(color: Colors.black, width: 0.5),
                title: '40%'
              ),
              // alimentação
              PieChartSectionData(
                value: 20,
                color: const Color.fromARGB(255, 109, 192, 114),
                radius: 80,
                borderSide: const BorderSide(color: Colors.black, width: 0.5),
                title: '20%'
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